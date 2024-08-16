ORG 0x7c00
BITS 16

; Print "Hello, World!"
start:
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
dw 0xaa55