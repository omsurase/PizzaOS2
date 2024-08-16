ORG 0
BITS 16


jmp 0x7c0:start

; Print "Hello, World!"
start:

    cli     ; clear interrupts
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7C00
    sti     ; enable interrupts

    mov si, message
    call print_string
    jmp $

; Function to print a null-terminated string
print_string:
    mov ah, 0x0e    ; BIOS teletype output

.loop:
    lodsb           ; Load next character into al
    cmp al, 0     ; Check if it's null (end of string)
    jz .done        ; If null, we're done
    int 0x10        ; Call BIOS interrupt to print character
    jmp .loop       ; Continue with next character

.done:
    ret

; Our message to print
message: db 'Hello, World!', 0

; Pad the rest of the boot sector with zeros
times 510-($-$$) db 0

; Boot signature
dw 0xAA55