                             #make_bin#

#LOAD_SEGMENT=FFFFh#
#LOAD_OFFSET=0000h#

#CS=0000h#
#IP=0000h#

#DS=0000h#
#ES=0000h#

#SS=0000h#
#SP=FFFEh#

#AX=0000h#
#BX=0000h#
#CX=0000h#
#DX=0000h#
#SI=0000h#
#DI=0000h#
#BP=0000h#
; this header has to remain
; add your code here
         jmp     st1 
         db     1021 dup(0)
         dw     0000
;CS is 2 bytes
         db     508 dup(0)     
         0ffff0h dw st1
;508 bytes filled with zeros for interrupt vectors 81H to FFH - that are not used.
;main program
;code segment will be in ROM         
st1:      cli 
          mov       ax,0200h
          mov       ds,ax
          mov       es,ax
          mov       ss,ax
          mov       sp,0FFFEH
          
;intialise portA as input portb,portc as output for the first 8255
          mov       al,10011000b
		  out 		06h,al        

;Keep polling port A until you get 1 from the switch
poll:     in        al,04h
          mov       bl,10h
          AND       AL,0F0H
          cmp       bl,al 
          jnz poll   
                                    
fpoll:

;Initialize portA,B as output and port C isnt connected
          mov       al,10000000b        
          out       0Eh,al        

                     
          mov cx,00h
 ; !!     ;Repeating Code Starts from here!!        -- 1               
 
          
          
star:     mov ah,00000000b
          mov dh,00000001b
          mov dl,8
star1:    mov       al,10000000b    ;Initialize 2nd 8255 to write data ;So port C in output mode
          out       0Eh,al 
          
          
          mov al,cl
          out 08h,al
          
          mov al,ch
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                             
          mov al,ah     ; Write from Port C of 2nd 8255
          out 0Ch,al    
                                            
          
          mov al,ch
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10001001b    ;Initialize 2nd 8255 to read data : So port C in input mode  
          out       0Eh,al         
          
          in al,0Ch
          
          mov bl,ah 
          cmp al,bl
          jnz nwow


          mov       al,10000000b    ;Initialize 2nd 8255 to write data ;So port C in output mode
          out       0Eh,al 
          
          
          mov al,cl
          out 08h,al
          
          mov al,ch
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                             
          mov al,dh     ; Write from Port C of 2nd 8255
          out 0Ch,al    
                                            
          
          mov al,ch
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10001001b    ;Initialize 2nd 8255 to read data : So port C in input mode  
          out       0Eh,al         
          
          in al,0Ch
          
          mov bl,dh 
          cmp al,bl
          jnz nwow
          rol dh,1 
          dec dl 
          cmp dl,0                               
          jnz star1                                                    
 


inc cx
cmp cx,8192d
jz wow

jmp  star
                                                           
          
   
;Fail on LED               
           

nwow:     MOV AL,01H
          OUT 04H,AL

          MOV AL,8EH
          OUT 02H,AL    
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL
          
          MOV AL,02H
          OUT 04H,AL
          
          MOV AL,88H
          OUT 02H,AL 
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL
          
          MOV AL,04H
          OUT 04H,AL   
          
          MOV AL,0F9H
          OUT 02H,AL 
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL
          
          MOV AL,08H
          OUT 04H,AL
          
          MOV AL,0C7H
          OUT 02H,AL
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL     
          
          in        al,04h
          mov       bl,10h
          and       al,0f0h
          cmp       bl,al 
          jz fpoll  
                            
          
          jmp nwow
                         
;Pass on LED       

           
                    
wow:      ;mov al,0FFh
          ;out 04,al 

          MOV AL,01H
          OUT 04H,AL

          MOV AL,10001100B
          OUT 02H,AL    
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL
          
          MOV AL,02H
          OUT 04H,AL
          
          MOV AL,88H
          OUT 02H,AL 
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL
          
          MOV AL,04H
          OUT 04H,AL   
          
          MOV AL,92H
          OUT 02H,AL 
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL
          
          MOV AL,08H
          OUT 04H,AL
          
          MOV AL,92H
          OUT 02H,AL
          
          MOV AL,00H
          OUT 04H,AL       
          
          MOV AL,0FFH
          OUT 02H,AL
                
          
          in        al,04h
          mov       bl,10h
          AND       AL,0F0H
          cmp       bl,al 
          jz fpoll  
                            
          
          jmp wow