#pragma warning disable
page 50058 "Germination Determination"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 50027;
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = all;
                }
                field("Item Product Group Code"; "Item Product Group Code")
                {
                    ApplicationArea = all;
                }
                field("Item Class of Seeds"; "Item Class of Seeds")
                {
                    ApplicationArea = all;
                }
                field("Qty (Kg)"; "Qty (Kg)")
                {
                    ApplicationArea = all;
                }
                field("Bute No."; "Bute No.")
                {
                    ApplicationArea = all;
                }
                field(Stage; Stage)
                {
                    ApplicationArea = all;
                }
                field("Received Date Time"; "Received Date Time")
                {
                    ApplicationArea = all;
                }
                field("Date of Putting"; "Date of Putting")
                {
                    ApplicationArea = all;
                }
                field("Date of Test"; "Date of Test")
                {
                    ApplicationArea = all;
                }
                field("Sample Code"; "Sample Code")
                {
                    ApplicationArea = all;
                }
                field("Subjected to Count II"; "Subjected to Count II")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF Rec."Subjected to Count II" = FALSE THEN
                            Count2Editable := FALSE
                        ELSE
                            Count2Editable := TRUE;
                        CurrPage.UPDATE;
                    end;
                }
            }
            Grid("Count I")
            {
                //GridLayout = Rows;
                group(Result)
                {
                    Grid("Count-1")
                    {
                        //GridLayout = Rows;
                        group(R_1)
                        {
                            Caption = 'R-I';
                            field("Count I R-I NSL"; "Count I R-I NSL")
                            {
                                ApplicationArea = all;
                                Caption = 'Normal Seed Lings   ';

                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-I NSL" <> 0 THEN BEGIN
                                    //Rec.VALIDATE("Count I Total NSL",Rec."Count I R-I NSL");
                                    //Rec.VALIDATE("Count I %",(Rec."Count I R-I NSL")/4);
                                    IF "Count I R-I NSL" > 100 THEN
                                        ERROR('You cannot enter more than 100');
                                    MaxNSLPrcntge := FALSE;
                                    NSLPrcntge := FALSE;
                                    IF Rec."Count I %" <> 0 THEN BEGIN
                                        //Codeunit50000.CalculateResult(Rec."Item No.", 6, Rec."Count I %", NSLPrcntge, MaxNSLPrcntge);
                                        IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                                            Count2Editable := FALSE
                                        ELSE
                                            Count2Editable := TRUE;
                                    END;
                                    //END;
                                    Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                                    CurrPage.UPDATE;
                                end;
                            }
                            field("Count I R-I ASL"; "Count I R-I ASL")
                            {
                                ApplicationArea = all;
                                Caption = 'Abnormal Seed Lings';

                                trigger OnValidate()
                                begin
                                    IF "Count I R-I ASL" > 100 THEN
                                        ERROR('You cannot enter more than 100');
                                    //IF Rec."Count I R-I ASL" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total ASL",Rec."Count I R-I ASL");
                                    //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                                end;
                            }
                            field("Count I R-I FUG"; "Count I R-I FUG")
                            {
                                ApplicationArea = all;
                                Caption = 'Fresh Un-Germinated';

                                trigger OnValidate()
                                begin
                                    IF "Count I R-I FUG" > 100 THEN
                                        ERROR('You cannot enter more than 100');

                                    //IF Rec."Count I R-I FUG" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total FUG",Rec."Count I R-I FUG");
                                    //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                                end;
                            }
                            field("Count I R-I HS"; "Count I R-I HS")
                            {
                                Caption = 'Hard Seed                     ';
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    IF "Count I R-I HS" > 100 THEN
                                        ERROR('You cannot enter more than 100');

                                    //IF Rec."Count I R-I HS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total HS",Rec."Count I R-I HS");
                                    //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                                end;
                            }
                            field("Count I R-I DS"; "Count I R-I DS")
                            {
                                Caption = 'Dead Seed                   ';
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    IF "Count I R-I DS" > 100 THEN
                                        ERROR('You cannot enter more than 100');

                                    //IF Rec."Count I R-I DS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total DS",Rec."Count I R-I DS");
                                    //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                                end;
                            }
                            field("Count I R-I T"; "Count I R-I T")
                            {
                                ApplicationArea = all;
                                Caption = 'Total                                ';
                            }
                            field("11"; varable)
                            {
                                ApplicationArea = all;
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                            }
                            field("1<Control1000000158>"; varable)
                            {
                                ApplicationArea = all;
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                            }
                        }
                    }
                    Grid(Grid1)
                    {
                        //GridLayout = Rows;
                        group("R_II")
                        {
                            Caption = 'R-II';
                            field("Count I R-II NSL"; "Count I R-II NSL")
                            {
                                ApplicationArea = all;
                                ShowCaption = false;

                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-II NSL" <> 0 THEN BEGIN
                                    //Rec.VALIDATE("Count I Total NSL",Rec."Count I R-I NSL" + Rec."Count I R-II NSL");
                                    //Rec.VALIDATE("Count I %",(Rec."Count I R-I NSL" + Rec."Count I R-II NSL")/4);
                                    MaxNSLPrcntge := FALSE;
                                    NSLPrcntge := FALSE;
                                    IF Rec."Count I %" <> 0 THEN BEGIN
                                        // Codeunit50000.CalculateResult(Rec."Item No.", 6, Rec."Count I %", NSLPrcntge, MaxNSLPrcntge);
                                        IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                                            Count2Editable := FALSE
                                        ELSE
                                            Count2Editable := TRUE;
                                    END;
                                    //END;
                                    Rec.VALIDATE("Count I R-II T", Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                                    CurrPage.UPDATE;
                                end;
                            }
                            field("Count I R-II ASL"; "Count I R-II ASL")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-II ASL" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total ASL",Rec."Count I R-I ASL" + Rec."Count I R-II ASL");
                                    //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                                end;
                            }
                            field("Count I R-II FUG"; "Count I R-II FUG")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-II FUG" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total FUG",Rec."Count I R-I FUG" + Rec."Count I R-II FUG");
                                    //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                                end;
                            }
                            field("Count I R-II HS"; "Count I R-II HS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-II HS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total HS",Rec."Count I R-I HS" + Rec."Count I R-II HS");
                                    //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                                end;
                            }
                            field("Count I R-II DS"; "Count I R-II DS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-II DS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total DS",Rec."Count I R-I DS" + Rec."Count I R-II DS");
                                    //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                                end;
                            }
                            field("Count I R-II T"; "Count I R-II T")
                            {
                                ApplicationArea = all;
                                ShowCaption = false;
                            }
                            field("0<Control1000000070>"; varable)
                            {
                                ApplicationArea = all;
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                            }
                            field("11<Control1000000158>"; varable)
                            {
                                ApplicationArea = all;
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                            }
                        }
                    }
                    Grid(Grid2)
                    {
                        //GridLayout = Rows;
                        group("R_III")
                        {
                            Caption = 'R-III';
                            field("Count I R-III NSL"; "Count I R-III NSL")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-III NSL" <> 0 THEN BEGIN
                                    //Rec.VALIDATE("Count I Total NSL",Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL");
                                    //Rec.VALIDATE("Count I %",(Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL")/4);
                                    MaxNSLPrcntge := FALSE;
                                    NSLPrcntge := FALSE;
                                    IF Rec."Count I %" <> 0 THEN BEGIN
                                        //Codeunit50000.CalculateResult(Rec."Item No.", 6, Rec."Count I %", NSLPrcntge, MaxNSLPrcntge);
                                        IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                                            Count2Editable := FALSE
                                        ELSE
                                            Count2Editable := TRUE;
                                    END;
                                    //END;
                                    Rec.VALIDATE("Count I R-III T", Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                                    CurrPage.UPDATE;
                                end;
                            }
                            field("Count I R-III ASL"; "Count I R-III ASL")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-III ASL" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total ASL",Rec."Count I R-I ASL" + Rec."Count I R-II ASL" + Rec."Count I R-III ASL");
                                    //Rec.VALIDATE("Count I R-III T",Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                                end;
                            }
                            field("Count I R-III FUG"; "Count I R-III FUG")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-III FUG" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total FUG",Rec."Count I R-I FUG" + Rec."Count I R-II FUG" + Rec."Count I R-III FUG");
                                    //Rec.VALIDATE("Count I R-III T",Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                                end;
                            }
                            field("Count I R-III HS"; "Count I R-III HS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-III HS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total HS",Rec."Count I R-I HS" + Rec."Count I R-II HS" + Rec."Count I R-III HS");
                                    //Rec.VALIDATE("Count I R-III T",Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                                end;
                            }
                            field("Count I R-III DS"; "Count I R-III DS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-III DS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total DS",Rec."Count I R-I DS" + Rec."Count I R-II DS" + Rec."Count I R-III DS");
                                    //Rec.VALIDATE("Count I R-III T",Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                                end;
                            }
                            field("Count I R-III T"; "Count I R-III T")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("111<Control1000000158>"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("00<Control1000000071>"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                        }
                    }
                    Grid(Grid3)
                    {
                        //GridLayout = Rows;
                        group("R_IV")
                        {
                            Caption = 'R-IV';
                            field("Count I R-IV NSL"; "Count I R-IV NSL")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-IV NSL" <> 0 THEN BEGIN
                                    //Rec.VALIDATE("Count I Total NSL",Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL");
                                    //Rec.VALIDATE("Count I %",(Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL")/4);
                                    MaxNSLPrcntge := FALSE;
                                    NSLPrcntge := FALSE;

                                    IF Rec."Count I %" <> 0 THEN BEGIN
                                        //Codeunit50000.CalculateResult(Rec."Item No.", 6, Rec."Count I %", NSLPrcntge, MaxNSLPrcntge);
                                        IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                                            Count2Editable := FALSE
                                        ELSE
                                            Count2Editable := TRUE;
                                    END;
                                    //END;
                                    Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                                    CurrPage.UPDATE;
                                end;
                            }
                            field("Count I R-IV ASL"; "Count I R-IV ASL")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-IV ASL" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total ASL",Rec."Count I R-I ASL" + Rec."Count I R-II ASL" + Rec."Count I R-III ASL" + Rec."Count I R-IV ASL");
                                    //Rec.VALIDATE("Count I R-IV T",Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                                end;
                            }
                            field("Count I R-IV FUG"; "Count I R-IV FUG")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-IV FUG" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total FUG",Rec."Count I R-I FUG" + Rec."Count I R-II FUG" + Rec."Count I R-III FUG" + Rec."Count I R-IV FUG");
                                    //Rec.VALIDATE("Count I R-IV T",Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                                end;
                            }
                            field("Count I R-IV HS"; "Count I R-IV HS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-IV HS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total HS",Rec."Count I R-I HS" + Rec."Count I R-II HS" + Rec."Count I R-III HS" + Rec."Count I R-IV HS");
                                    //Rec.VALIDATE("Count I R-IV T",Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                                end;
                            }
                            field("Count I R-IV DS"; "Count I R-IV DS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                                trigger OnValidate()
                                begin
                                    //IF Rec."Count I R-IV DS" <> 0 THEN
                                    //Rec.VALIDATE("Count I Total DS",Rec."Count I R-I DS" + Rec."Count I R-II DS" + Rec."Count I R-III DS" + Rec."Count I R-IV DS");
                                    //Rec.VALIDATE("Count I R-IV T",Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                                end;
                            }
                            field("Count I R-IV T"; "Count I R-IV T")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("1111<Control1000000158>"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("000<Control1000000072>"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                        }
                    }
                    Grid(Grid4)
                    {
                        //GridLayout = Rows;
                        group(Total_)
                        {
                            Caption = 'Total';
                            field("Count I Total NSL"; "Count I Total NSL")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }

                            field("Count I Total ASL"; "Count I Total ASL")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("Count I Total FUG"; "Count I Total FUG")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("Count I Total HS"; "Count I Total HS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("Count I Total DS"; "Count I Total DS")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("Count I Total T"; "Count I Total T")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("111111<Control1000000158>"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("00000<Control1000000074>"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                        }
                    }
                    Grid(Grid5)
                    {
                        //GridLayout = Rows;
                        group("Count_I %")
                        {
                            Caption = 'Count I %';
                            field("Count I %"; "Count I %")
                            {
                                Caption = '%';
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("69"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("70"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("71"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("069"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("070"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("071"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                        }
                    }
                    Grid(Grid6)
                    {
                        //GridLayout = Rows;
                        group("Count_I Result")
                        {
                            Caption = 'Count I Result';
                            field("Count I Result"; "Count I Result")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("169"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("170"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("171"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("0169"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("0170"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("0171"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                        }
                    }
                    Grid(Grid7)
                    {
                        //GridLayout = Rows;
                        group("Count_I Result Date")
                        {
                            Caption = 'Count I Result Date';
                            field("Count I Result Date"; "Count I Result Date")
                            {
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("269"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("270"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("271"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("0269"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("0270"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                            field("0271"; varable)
                            {
                                Editable = false;
                                Enabled = false;
                                Lookup = true;
                                ShowCaption = false;
                                ApplicationArea = all;
                            }
                        }
                    }
                }
            }
            // Grid("Count II")
            // {
            //     ////GridLayout = Rows;
            //     group(CountII)
            //     {
            //         Editable = Count2Editable;
            //         Grid(Grid8)
            //         {
            //             //GridLayout = Rows;
            //             group("R-I")
            //             {
            //                 Caption = 'R-I';
            //                 field("Count II R-I NSL"; "Count II R-I NSL")
            //                 {
            //                     Caption = 'Normal Seed Lings   ';
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-I NSL" <> 0 THEN BEGIN
            //                         //  Rec.VALIDATE("Count II Total NSL",Rec."Count II R-I NSL");
            //                         //  Rec.VALIDATE("Count II %",(Rec."Count II R-I NSL")/4);
            //                         //END;
            //                         //Rec.VALIDATE("Count II R-I T",Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
            //                     end;
            //                 }
            //                 field("Count II R-I ASL"; "Count II R-I ASL")
            //                 {
            //                     Caption = 'Abnormal Seed Lings';
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-I ASL" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total ASL",Rec."Count II R-I ASL");
            //                         //Rec.VALIDATE("Count II R-I T",Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
            //                     end;
            //                 }
            //                 field("Count II R-I FUG"; "Count II R-I FUG")
            //                 {
            //                     Caption = 'Fresh Un-Germinated';
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-I FUG" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total FUG",Rec."Count II R-I FUG");
            //                         //Rec.VALIDATE("Count II R-I T",Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
            //                     end;
            //                 }
            //                 field("Count II R-I HS"; "Count II R-I HS")
            //                 {
            //                     Caption = 'Hard Seed                     ';
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-I HS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total HS",Rec."Count II R-I HS");
            //                         //  Rec.VALIDATE("Count II R-I T",Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
            //                     end;
            //                 }
            //                 field("Count II R-I DS"; "Count II R-I DS")
            //                 {
            //                     Caption = 'Dead Seed                   ';
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-I DS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total DS",Rec."Count II R-I DS");
            //                         //Rec.VALIDATE("Count II R-I T",Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
            //                     end;
            //                 }
            //                 field("Count II R-I T"; "Count II R-I T")
            //                 {
            //                     Caption = 'Total';
            //                     ApplicationArea = all;
            //                 }
            //                 field("0<Control1000000165>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("1<Control1000000164>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }
            //         Grid(Grid9)
            //         {
            //             //GridLayout = Rows;
            //             group("R-II")
            //             {
            //                 Caption = 'R-II';
            //                 field("Count II R-II NSL"; "Count II R-II NSL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-II NSL" <> 0 THEN BEGIN
            //                         //  Rec.VALIDATE("Count II Total NSL",Rec."Count II R-I NSL" + Rec."Count II R-II NSL");
            //                         //Rec.VALIDATE("Count II %",(Rec."Count II R-I NSL" + Rec."Count II R-II NSL")/4);
            //                         //END;
            //                         //Rec.VALIDATE("Count II R-II T",Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
            //                     end;
            //                 }
            //                 field("Count II R-II ASL"; "Count II R-II ASL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-II ASL" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total ASL",Rec."Count II R-I ASL" + Rec."Count II R-II ASL");
            //                         //Rec.VALIDATE("Count II R-II T",Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
            //                     end;
            //                 }
            //                 field("Count II R-II FUG"; "Count II R-II FUG")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-II FUG" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total FUG",Rec."Count II R-I FUG" + Rec."Count II R-II FUG");
            //                         //Rec.VALIDATE("Count II R-II T",Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
            //                     end;
            //                 }
            //                 field("Count II R-II HS"; "Count II R-II HS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-II HS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total HS",Rec."Count II R-I HS" + Rec."Count II R-II HS");
            //                         //Rec.VALIDATE("Count II R-II T",Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
            //                     end;
            //                 }
            //                 field("Count II R-II DS"; "Count II R-II DS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-II DS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total DS",Rec."Count II R-I DS" + Rec."Count II R-II DS");
            //                         //Rec.VALIDATE("Count II R-II T",Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
            //                     end;
            //                 }
            //                 field("Count II R-II T"; "Count II R-II T")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("4<Control1000000167>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                 }
            //                 field("3<Control1000000158>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }

            //         Grid(Grid10)
            //         {
            //             //GridLayout = Rows;
            //             group("R-III")
            //             {
            //                 Caption = 'R-III';
            //                 field("Count II R-III NSL"; "Count II R-III NSL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-III NSL" <> 0 THEN BEGIN
            //                         //Rec.VALIDATE("Count II Total NSL",Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL");
            //                         //Rec.VALIDATE("Count II %",(Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL")/4);
            //                         //END;
            //                         //Rec.VALIDATE("Count II R-III T",Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
            //                     end;
            //                 }
            //                 field("Count II R-III ASL"; "Count II R-III ASL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-III ASL" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total ASL",Rec."Count II R-I ASL" + Rec."Count II R-II ASL" + Rec."Count II R-III ASL");
            //                         //Rec.VALIDATE("Count II R-III T",Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
            //                     end;
            //                 }
            //                 field("Count II R-III FUG"; "Count II R-III FUG")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-III FUG" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total FUG",Rec."Count II R-I FUG" + Rec."Count II R-II FUG" + Rec."Count II R-III FUG");
            //                         //Rec.VALIDATE("Count II R-III T",Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
            //                     end;
            //                 }
            //                 field("Count II R-III HS"; "Count II R-III HS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-III HS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total HS",Rec."Count II R-I HS" + Rec."Count II R-II HS" + Rec."Count II R-III HS");
            //                         //Rec.VALIDATE("Count II R-III T",Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
            //                     end;
            //                 }
            //                 field("Count II R-III DS"; "Count II R-III DS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-III DS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total DS",Rec."Count II R-I DS" + Rec."Count II R-II DS" + Rec."Count II R-III DS");
            //                         //Rec.VALIDATE("Count II R-III T",Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
            //                     end;
            //                 }
            //                 field("Count II R-III T"; "Count II R-III T")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("5<Control1000000169>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("6<Control1000000158>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }
            //         Grid(Grid11)
            //         {
            //             //GridLayout = Rows;
            //             group("R-IV")
            //             {
            //                 Caption = 'R-IV';
            //                 field("Count II R-IV NSL"; "Count II R-IV NSL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-IV NSL" <> 0 THEN BEGIN
            //                         //Rec.VALIDATE("Count II Total NSL",Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL");
            //                         //Rec.VALIDATE("Count II %",(Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL")/4);
            //                         //END;
            //                         //Rec.VALIDATE("Count II R-IV T",Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
            //                     end;
            //                 }
            //                 field("Count II R-IV ASL"; "Count II R-IV ASL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-IV ASL" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total ASL",Rec."Count II R-I ASL" + Rec."Count II R-II ASL" + Rec."Count II R-III ASL" + Rec."Count II R-IV ASL");
            //                         //Rec.VALIDATE("Count II R-IV T",Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
            //                     end;
            //                 }
            //                 field("Count II R-IV FUG"; "Count II R-IV FUG")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-IV FUG" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total FUG",Rec."Count II R-I FUG" + Rec."Count II R-II FUG" + Rec."Count II R-III FUG" + Rec."Count II R-IV FUG");
            //                         //Rec.VALIDATE("Count II R-IV T",Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
            //                     end;
            //                 }
            //                 field("Count II R-IV HS"; "Count II R-IV HS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-IV HS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total HS",Rec."Count II R-I HS" + Rec."Count II R-II HS" + Rec."Count II R-III HS" + Rec."Count II R-IV HS");
            //                         //Rec.VALIDATE("Count II R-IV T",Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
            //                     end;
            //                 }
            //                 field("Count II R-IV DS"; "Count II R-IV DS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                     trigger OnValidate()
            //                     begin
            //                         //IF Rec."Count II R-IV DS" <> 0 THEN
            //                         //Rec.VALIDATE("Count II Total DS",Rec."Count II R-I DS" + Rec."Count II R-II DS" + Rec."Count II R-III DS" + Rec."Count II R-IV DS");
            //                         //Rec.VALIDATE("Count II R-IV T",Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
            //                     end;
            //                 }
            //                 field("Count II R-IV T"; "Count II R-IV T")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("7<Control1000000171>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("8<Control1000000158>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }
            //         Grid(Grid12)
            //         {
            //             //GridLayout = Rows;
            //             group(Total)
            //             {
            //                 Caption = 'Total';
            //                 field("Count II Total NSL"; "Count II Total NSL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("Count II Total ASL"; "Count II Total ASL")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("Count II Total FUG"; "Count II Total FUG")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("Count II Total HS"; "Count II Total HS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("Count II Total DS"; "Count II Total DS")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }

            //                 field("Count II Total T"; "Count II Total T")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("9<Control1000000173>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("01<Control1000000158>"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }
            //         Grid(Grid13)
            //         {
            //             //GridLayout = Rows;
            //             group("Count_II %")
            //             {
            //                 Caption = 'Count II %';
            //                 field("Count II %"; "Count II %")
            //                 {
            //                     Caption = '%';
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("0069"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("0070"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("0071"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("00069"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("00070"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("00071"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }
            //         Grid(Grid14)
            //         {
            //             //GridLayout = Rows;
            //             group("Count_II Result")
            //             {
            //                 Caption = 'Count II Result';
            //                 field("Count II Result"; "Count II Result")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("2169"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("2170"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("2171"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("10169"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("10170"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("10171"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }
            //         Grid(Grid15)
            //         {
            //             //GridLayout = Rows;
            //             group("Count_II Result Date")
            //             {
            //                 Caption = 'Count II Result Date';
            //                 field("Count II Result Date"; "Count II Result Date")
            //                 {
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("2269"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("1270"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("2271"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("10269"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("20270"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //                 field("10271"; varable)
            //                 {
            //                     Editable = false;
            //                     Enabled = false;
            //                     Lookup = true;
            //                     ShowCaption = false;
            //                     ApplicationArea = all;
            //                 }
            //             }
            //         }
            //     }
            // }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Rec."Count I Result" <> Rec."Count I Result"::" " THEN BEGIN
                        Rec.Posted := TRUE;
                        Rec.MODIFY;
                        //ProcessTransferPostYesNo.UpdateQCResultDeclaration("Bute No.", "Sample Code", 3, Results,
                        //"Final Result User Id", "Date of Test", Results);
                    END ELSE
                        ERROR('Count I Result is not declared yet. Please declare it first.');
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Posted = TRUE THEN
            editvalue := FALSE
        ELSE
            editvalue := TRUE;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //UserPermission
        //    ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //UserPermission
        //    ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
        //CurrPage.UPDATE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //UserPermission
        //   ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnOpenPage()
    begin
        //UserPermission
        //Check already exist or not
        // CanView := FALSE;
        // ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        // ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDNULW(CanView, CanInsert, Var_Locations, 17);
        // IF CanView = FALSE THEN
        //     ERROR(ContactAdminText003)
        // ELSE BEGIN
        //     IF CanInsert <> TRUE THEN
        //         CurrPage.EDITABLE(FALSE);
        // END;

        // IF Rec."Subjected to Count II" = FALSE THEN
        //     Count2Editable := FALSE
        // ELSE
        //     Count2Editable := TRUE;
    end;

    var
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        Count2Editable: Boolean;
        varable: Text;
        NSLPrcntge: Boolean;
        Codeunit50000: Codeunit 50000;
        recUL: Record "User Location";
        CanView: Boolean;
        CanInsert: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
        MaxNSLPrcntge: Boolean;
        editvalue: Boolean;
}

