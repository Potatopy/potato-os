org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A

;
; FAT12 header
;
jmp short start
nop
bdb_oem:                        db 'MSWIN4.1' ; 8 bytes
bdb_bytes_per_sector:           dw 512        
bdb_secotrs_per_cluster:        db 1
bdb_reserved_sectors:           dw 1
bdb_dat_count:                  db 2
bdb_dir_entries_count:          dw 0E0h       ; 2880 * 512 = 1.44MB
bdb_total_sectors:              dw 2880       ; F0 = 3.5" floppy disk
bdb_media_descriptor_type:      db 0F0h       ; 9 sectors/fat
bdb_sectors_per_fat:            dw 9
bdb_sectors_per_track:          dw 18
bdb_heads:                      dw 2
bdb_hidden_sectors:             dd 0
bdb_large_sector_count:         dd 0

# extended boot record
ebr_drive_number: db 0                        ; 0x00 floppy, 0x80 hdd
                  db 0                        ; reserved
ebr_signature:    db 29h
ebr_volume_id:    db 12h, 34h, 56h, 78h       ; serial number
ebr_volume_label: db 'POTATO OS    '              ; 11 bytes, padded with spaces
ebr_system_id:    db 'FAT12       '

start:
    jmp main


;
; Prints a string to the screen
; Params:
;   - ds:si points to string
;
puts:
    ; save registers we will modify
    push si
    push ax
    push bx

.loop:
    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz .done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si    
    ret
    

main:
    ; setup data segments
    mov ax, 0           ; can't set ds/es directly
    mov ds, ax
    mov es, ax
    
    ; setup stack
    mov ss, ax
    mov sp, 0x7C00      ; stack grows downwards from where we are loaded in memory

    ; print hello world message
    mov si, msg_hello
    call puts

    hlt

.halt
    jmp .halt

;
; Disk routines
;

;
; Converts an LBA adress to a CHS address
; Paramaters:
;   - ax: LBA address
; Returns:
;   - cx [bits 0-5]: sector number
;   - cx [bits 6-15]: cylinder
;   - dh: head
;

lba_to_chs:

    push ax
    push dx
    
    xor dx, dx                          ; dx = 0
    div word [bdb_sectors_per_track]    ; ax = LBA / SectorsPerTrack
                                        ; dx = LBA % SectorsPerTrack
    
    inc dx                              ; dx = (LBA % SectorsPerTrack + 1) = sector
    mov cx, dx                          ; cx = sector

    xor dx, dx                          ; dx = 0
    div word [bdb_heads]                ; ax = (LBA / SectorsPerTrack)
                                        ; dx = (LBA / SectorsPerTrack) % Heads = head
    mov dh, dl                          ; dh = head
    mov ch, al                          ; ch = cylinder lower 8 bits 
    shl ah, 6
    or cl, ah                           ; put upper 2 bits of cylinder in CL 

    pop ax
    mov dl, al                          ; restore dl
    pop ax         
    ret

;
; Reads sectors from a disk
; Params:
;   - ax: LBA address
;   - cl: number of sectors to read (max: 128)
;   - dl: drive number
;              


msg_hello: db 'Hello world!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h