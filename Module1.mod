MODULE Module1
    !!!!!
	PERS tooldata tFix:=[TRUE,[[0,0,50],[1,0,0,0]],[0.1,[0,0,10],[1,0,0,0],0,0,0]];
	CONST jointtarget jHome:=[[0,0,0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	CONST robtarget pBox:=[[298.35,-4.43,217.57],[5.90494E-9,0.812075,0.583553,7.96518E-9],[-1,0,1,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    VAR num nCykly:=0;
    VAR num nAktCykly:=0;
    VAR num nKostkaSize:=0;
    VAR intnum iStop;
    PERS num nRanni0:=0;
    PERS num nRanni1:=6;
    PERS num nRanni2:=0;
    PERS num nRanni3:=35;
    PERS num nRanni4:=25;
    PERS num nRanni5:=0;
    PERS num nOdpoledni0:=144;
    PERS num nOdpoledni1:=60;
    PERS num nOdpoledni2:=9;
    PERS num nOdpoledni3:=5;
    PERS num nOdpoledni4:=144;
    PERS num nOdpoledni5:=0;
    PERS num nNocni0:=0;
    PERS num nNocni1:=0;
    PERS num nNocni2:=1;
    PERS num nNocni3:=10;
    PERS num nNocni4:=0;
    PERS num nNocni5:=0;
    PERS num nDen1:=66;
    PERS num nDen2:=10;
    PERS num nDen3:=50;
    PERS num nDen4:=169;
    PERS num nDen5:=0;
    PERS num nTotalWeek:=665;
    PERS num nTotal:=144;
    VAR num nWeekDay:=0;
    VAR num nHour:=0;
    VAR string ranni_str;
    VAR string odpoledni_str;
    VAR string nocni_str;
    !!!!!
    PROC main()
        nAktCykly:=0;
        !CONNECT iStop WITH rStop;
        !ITimer 10, iStop;
        TPErase;
        TPReadNum nCykly, "Kolik  cyklu  mam  udelat?";
        TPReadNum nKostkaSize, "Jak velka ma byt kostka?";
        WHILE nAktCykly < nCykly DO
            rZapisKus;
            rUloha;
            Incr nAktCykly;
        ENDWHILE
    ENDPROC
    !!!!! Pocitadlo kusu !!!!!
    PROC rZjistiCas()
        nWeekDay:= GetTime(\WDay);
        nHour:= GetTime(\Hour);
    ENDPROC
    PROC rZapisDen1()
        IF nHour >= 6 AND nHour <= 13 THEN
            Incr nRanni1;
        ELSEIF nHour >= 14 AND nHour <= 21 THEN
            Incr nOdpoledni1;
        ELSEIF nHour >= 22 AND nHour <= 5 THEN
            Incr nNocni1;
        ENDIF
    ENDPROC
    PROC rZapisDen2()
        IF nHour >= 6 AND nHour <= 13 THEN
            Incr nRanni2;
        ELSEIF nHour >= 14 AND nHour <= 21 THEN
            Incr nOdpoledni2;
        ELSEIF nHour >= 22 AND nHour <= 5 THEN
            Incr nNocni2;
        ENDIF
    ENDPROC
    PROC rZapisDen3()
        IF nHour >= 6 AND nHour <= 13 THEN
            Incr nRanni3;
        ELSEIF nHour >= 14 AND nHour <= 21 THEN
            Incr nOdpoledni3;
        ELSEIF nHour >= 22 AND nHour <= 5 THEN
            Incr nNocni3;
        ENDIF
    ENDPROC
    PROC rZapisDen4()
        IF nHour >= 6 AND nHour <= 13 THEN
            Incr nRanni4;
        ELSEIF nHour >= 14 AND nHour <= 21 THEN
            Incr nOdpoledni4;
        ELSEIF nHour >= 22 AND nHour <= 5 THEN
            Incr nNocni4;
        ENDIF
    ENDPROC
    PROC rZapisDen5()
        IF nHour >= 6 AND nHour <= 13 THEN
            Incr nRanni5;
        ELSEIF nHour >= 14 AND nHour <= 21 THEN
            Incr nOdpoledni5;
        ELSEIF nHour >= 22 AND nHour <= 5 THEN
            Incr nNocni5;
        ENDIF
    ENDPROC
    PROC rZapisKusTotal()
        IF nHour >= 6 AND nHour <= 13 THEN
            Incr nRanni0;
        ELSEIF nHour >= 14 AND nHour <= 21 THEN
            Incr nOdpoledni0;
        ELSEIF nHour >= 22 AND nHour <= 5 THEN
            Incr nNocni0;
        ENDIF
        Incr nTotal;
        Incr nTotalWeek;
    ENDPROC
    PROC rZapisKus()
        rZjistiCas;
        rZapisResetWeekly;
        IF nWeekDay = 1 THEN
            rZapisDen1;
        ELSEIF nWeekDay = 2 THEN
            rZapisDen2;
        ELSEIF nWeekDay = 3 THEN
            rZapisDen3;
        ELSEIF nWeekDay = 4 THEN
            rZapisDen4;
        ELSEIF nWeekDay = 5 THEN
            rZapisDen5;
        ENDIF
        rSectiKusy;
        rZapisKusTotal;
        rVypsani;
    ENDPROC
    PROC rSectiKusy()
        nDen1:= nRanni1 + nOdpoledni1 + nNocni1;
        nDen2:= nRanni2 + nOdpoledni2 + nNocni2;
        nDen3:= nRanni3 + nOdpoledni3 + nNocni3;
        nDen4:= nRanni4 + nOdpoledni4 + nNocni4;
        nDen5:= nRanni5 + nOdpoledni5 + nNocni5;
    ENDPROC
   PROC rZapisResetWeekly()
        IF nDen2 > 1 AND nWeekDay = 1 THEN
            rZapisReset;
        ELSEIF nDen3 > 1 AND nWeekDay = 2 THEN
           rZapisReset;
        ELSEIF nDen4 > 1 AND nWeekDay = 3 THEN
            rZapisReset;
        ELSEIF nDen5 > 1 AND nWeekDay = 4 THEN
            rZapisReset;
       ENDIF
   ENDPROC
   PROC rZapisReset()
        nRanni0:=0;
        nRanni1:=0;
        nRanni2:=0;
        nRanni3:=0;
        nRanni4:=0;
        nRanni5:=0;
        nOdpoledni0:=0;
        nOdpoledni1:=0;
        nOdpoledni2:=0;
        nOdpoledni3:=0;
        nOdpoledni4:=0;
        nOdpoledni5:=0;
        nNocni0:=0;
        nNocni1:=0;
        nNocni2:=0;
        nNocni3:=0;
        nNocni4:=0;
        nNocni5:=0;
        nTotalWeek:=0;
   ENDPROC
    !!!!! Vypsani kusu !!!!!
PROC rVypsani()
    TPErase;
    TPWrite("         R    O    N    T");
    fFormatText nRanni1,nOdpoledni1,nNocni1,nDen1,1;
    fFormatText nRanni2,nOdpoledni2,nNocni2,nDen2,2;
    fFormatText nRanni3,nOdpoledni3,nNocni3,nDen3,3;
    fFormatText nRanni4,nOdpoledni4,nNocni4,nDen4,4;
    fFormatText nRanni5,nOdpoledni5,nNocni5,nDen5,5;
    fFormatText nRanni0,nOdpoledni0,nNocni0,nTotalWeek,6;
ENDPROC
    PROC fFormatText(num rannix,num odpolednix,num nocnix,num den,num day)
        IF rannix >= 100 THEN
            ranni_str:= "  " + NumToStr(rannix, 0);
        ELSEIF rannix >= 10 THEN
            ranni_str:= "   " + NumToStr(rannix, 0);
        ELSE
            ranni_str:= "    " + NumToStr(rannix, 0);
        ENDIF
    
        IF odpolednix >= 100 THEN
            odpoledni_str:= "  " + NumToStr(odpolednix, 0);
        ELSEIF odpolednix >= 10 THEN
            odpoledni_str:= "   " + NumToStr(odpolednix, 0);
        ELSE
            odpoledni_str:= "    " + NumToStr(odpolednix, 0);
        ENDIF
    
        IF nocnix >= 100 THEN
            nocni_str:= "  " + NumToStr(nocnix, 0);
        ELSEIF nocnix >= 10 THEN
            nocni_str:= "   " + NumToStr(nocnix, 0);
        ELSE
            nocni_str:= "    " + NumToStr(nocnix, 0);
        ENDIF
        TEST day
        CASE 1:
        TPWrite("Po   " + ranni_str + odpoledni_str + nocni_str + "    " + NumToStr(den, 0));
        CASE 2:
        TPWrite("Ut   " + ranni_str + odpoledni_str + nocni_str + "    " + NumToStr(den, 0));
        CASE 3:
        TPWrite("St   " + ranni_str + odpoledni_str + nocni_str + "    " + NumToStr(den, 0));
        CASE 4:
        TPWrite("Ct   " + ranni_str + odpoledni_str + nocni_str + "    " + NumToStr(den, 0));
        CASE 5:
        TPWrite("Pa   " + ranni_str + odpoledni_str + nocni_str + "    " + NumToStr(den, 0));
        CASE 6:
        TPWrite("Sum  " + ranni_str + odpoledni_str + nocni_str + "    " + NumToStr(den, 0));
        DEFAULT:
        ENDTEST
    ENDPROC
    PROC rHome()
        MoveABSJ jHome, v1000,fine,tfix;
    ENDPROC
    PROC rBox(num delka)
        MoveJ offs(pBox,0,0,100),v1000,z50,tFix;
        MoveL pBox,v200,z0,tfix\WObj:=wobj0;
        MoveL offs(pBox,0,delka,0),v200,z0,tfix\WObj:=wobj0;
        MoveL offs(pBox,delka,delka,0),v200,z0,tfix\WObj:=wobj0;
        MoveL offs(pBox,delka,0,0),v200,z0,tfix\WObj:=wobj0;
        MoveL pBox,v200,fine,tfix\WObj:=wobj0;
    ENDPROC
    PROC rUloha()
        rBox (nKostkaSize);
    ENDPROC
ENDMODULE