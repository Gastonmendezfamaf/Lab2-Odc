	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x10, 0xC7, lsl 16
	movk x10, 0x1585, lsl 00

	mov x2, SCREEN_HEIGH         // Y Size

	movz w10, 0x3F38, lsl 00 //Color tablero de negras
	movk w10, 0x4A, lsl 16
	
	movz w11, 0xBDB0, lsl 00 //Color tablero de blancas
	movk w11, 0xD0, lsl 16

	movk w12, 0x753F, lsl 00 //Color borde de tablero
	movk w12, 0xD9, lsl 16

	movz x4,60,lsl 00
loop1:
	mov x1, SCREEN_WIDTH         // X Size
	
loop2:
	movz x3,60,lsl 00
	add x0,x0,#80
square_painter: 
	bl paint_row
	add x0,x0,#200
	add x0,x0,#200
	sub x4,x4,1
	cbnz x4,square_painter
	mov x4,xzr
	add x4,x4,60

InfLoop:
	b InfLoop


paint_row:
	stur w11,[x0,#0] //paint first pixel
	add x0,x0,4 //select next pixel
	sub x3,x3,1 //decrements counter
	cbnz x3,paint_row//check if counter is zero
	mov x3,xzr//
	add x3,x3,#60//restores pixel counter
	br lr
