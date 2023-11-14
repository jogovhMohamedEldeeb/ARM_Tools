
/*
	@file : LinkerScript.ld
	@author : MOHAMED ELDEEB
	@brief : LinkerScript for STM32F407VGTX Device 
*/

_estack = ORIGIN(RAM) + LENGTH(RAM);	/* End of "RAM" ram type memory*/

_MIN_HEAB_SIZE = 0x200;		/* Required amount of heap*/
_MIN_STACK_SIZE = 0x400;	/* Required amount of stack*/

MEMORY
{
    RAM (xrw)  : ORIGIN = 0x2000000 , LENGTH = 20K
    FLASH (rx) : ORIGIN = 0x08000000 , LENGTH = 64K
}

SECTIONS
{	
		/* the startup code into "FLASH" ROM  type memory */
    .isr_Vector :
    {
        . = ALIGN(4);
        *(.isr_Vector*)
        . = ALIGN(4);
    }>FLASH
	
	
		/* .text section : the program code and other data into "FLASH" ROM  type memory  */
    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        . = ALIGN(4);
        _etext = .; 
    }>FLASH
		/* .rodata section : constant data into "FLASH" ROM  type memory  */
    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
        _erodata = .; 
    }>FLASH

    _sidata = LOADADDR(.data); /* contain load memory from data segment */

	   /* .data section : Intialized data data into "RAM" Ram type memory  */
    .data :
    {
        _sdata = .;
        . = ALIGN(4);
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    }>RAM AT>FLASH

		/* .data section : Uniintialized data data into "RAM" Ram  type memory  */
    .bss :
    {
        _sbss = .;
        . = ALIGN(4);
        *(.bss)
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;
    }>RAM
}