table 50027 "Germination Evaluation"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                recul: Record "User Location";
                recLoc: Record Location;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE("Germination Determination", TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("GD Series");
                            NoSeriesMgt.TestManual(recLoc."GD Series");
                            "No. Series" := '';
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("GD Series"));
                    END ELSE
                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                END;
            end;
        }
        field(2; "Crop Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Crop Master".Code;
        }
        field(3; "Item No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Qty (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Stage; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Sample Receiving Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Putting"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Date of Test"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Normal Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Abnormal Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Hard Seed Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Dead Seed Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Fresh Ungerminated Germi %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Results; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(16; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(19; "Count I R-I NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;

                IF "Count I R-I NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count I R-I NSL" <> 0 THEN
                //  Rec.VALIDATE("Count I R-II NSL",Rec."Count I R-I NSL" + 1)
                // ELSE
                //  Rec.VALIDATE("Count I R-II NSL",0);

                Rec.VALIDATE("Count I Total NSL", Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL");

                IF "Count I R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;


                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL") / percentagetobecalculate, 1, '='))
                ELSE
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL"), 1, '='));

                Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                IF "Count I R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(20; "Count I R-II NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;

                IF "Count I R-II NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total NSL", Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL");

                IF "Count I R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;

                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL") / percentagetobecalculate, 1, '='))
                ELSE
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL"), 1, '='));

                Rec.VALIDATE("Count I R-II T", Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                IF "Count I R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(21; "Count I R-III NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;

                IF "Count I R-III NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');

                // IF Rec."Count I R-III NSL" <> 0 THEN
                //  Rec.VALIDATE("Count I R-IV NSL",Rec."Count I R-III NSL" + 1)
                // ELSE
                //  Rec.VALIDATE("Count I R-IV NSL",0);

                IF "Count I R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;

                Rec.VALIDATE("Count I Total NSL", Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL");
                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL") / percentagetobecalculate, 1, '='))
                ELSE
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL"), 1, '='));

                Rec.VALIDATE("Count I R-III T", Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                IF "Count I R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(22; "Count I R-IV NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;
                IF "Count I R-IV NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total NSL", Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL");

                IF "Count I R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count I R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;

                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL") / percentagetobecalculate, 1, '='))
                ELSE
                    Rec.VALIDATE("Count I %", ROUND((Rec."Count I R-I NSL" + Rec."Count I R-II NSL" + Rec."Count I R-III NSL" + Rec."Count I R-IV NSL"), 1, '='));

                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                IF "Count I R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(23; "Count I Total NSL"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Count I R-I ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-I ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');

                // IF Rec."Count I R-I ASL" <> 0 THEN
                //  Rec.VALIDATE("Count I R-II ASL",Rec."Count I R-I ASL")
                // ELSE
                //  Rec.VALIDATE("Count I R-II ASL",0);



                Rec.VALIDATE("Count I Total ASL", Rec."Count I R-I ASL" + Rec."Count I R-II ASL" + Rec."Count I R-III ASL" + Rec."Count I R-IV ASL");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                IF "Count I R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(25; "Count I R-II ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-II ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total ASL", Rec."Count I R-I ASL" + Rec."Count I R-II ASL" + Rec."Count I R-III ASL" + Rec."Count I R-IV ASL");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-II T", Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                IF "Count I R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(26; "Count I R-III ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-III ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count I R-III ASL" <> 0 THEN
                //  Rec.VALIDATE("Count I R-IV ASL",Rec."Count I R-III ASL")
                // ELSE
                //  Rec.VALIDATE("Count I R-IV ASL",0);

                Rec.VALIDATE("Count I Total ASL", Rec."Count I R-I ASL" + Rec."Count I R-II ASL" + Rec."Count I R-III ASL" + Rec."Count I R-IV ASL");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-III T", Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                IF "Count I R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(27; "Count I R-IV ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-IV ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total ASL", Rec."Count I R-I ASL" + Rec."Count I R-II ASL" + Rec."Count I R-III ASL" + Rec."Count I R-IV ASL");
                //Rec.VALIDATE("Count I R-IV T",Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                IF "Count I R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(28; "Count I Total ASL"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Count I R-I FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-I FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');

                // IF Rec."Count I R-I FUG" <> 0 THEN
                //  Rec.VALIDATE("Count I R-II FUG",Rec."Count I R-I FUG" - 1)
                // ELSE
                //  Rec.VALIDATE("Count I R-II FUG",0);

                Rec.VALIDATE("Count I Total FUG", Rec."Count I R-I FUG" + Rec."Count I R-II FUG" + Rec."Count I R-III FUG" + Rec."Count I R-IV FUG");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                IF "Count I R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(30; "Count I R-II FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-II FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total FUG", Rec."Count I R-I FUG" + Rec."Count I R-II FUG" + Rec."Count I R-III FUG" + Rec."Count I R-IV FUG");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-II T", Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                IF "Count I R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(31; "Count I R-III FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-III FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count I R-III FUG" <> 0 THEN
                //  Rec.VALIDATE("Count I R-IV FUG",Rec."Count I R-III FUG" - 1)
                // ELSE
                //  Rec.VALIDATE("Count I R-IV FUG",0);

                Rec.VALIDATE("Count I Total FUG", Rec."Count I R-I FUG" + Rec."Count I R-II FUG" + Rec."Count I R-III FUG" + Rec."Count I R-IV FUG");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-III T", Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                IF "Count I R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(32; "Count I R-IV FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-IV FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total FUG", Rec."Count I R-I FUG" + Rec."Count I R-II FUG" + Rec."Count I R-III FUG" + Rec."Count I R-IV FUG");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                IF "Count I R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(33; "Count I Total FUG"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Count I R-I HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-I HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count I R-I HS" <> 0 THEN
                //  Rec.VALIDATE("Count I R-II HS",Rec."Count I R-I HS")
                // ELSE
                //  Rec.VALIDATE("Count I R-II HS",0);

                Rec.VALIDATE("Count I Total HS", Rec."Count I R-I HS" + Rec."Count I R-II HS" + Rec."Count I R-III HS" + Rec."Count I R-IV HS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                IF "Count I R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(35; "Count I R-II HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-II HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total HS", Rec."Count I R-I HS" + Rec."Count I R-II HS" + Rec."Count I R-III HS" + Rec."Count I R-IV HS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-II T", Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                IF "Count I R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(36; "Count I R-III HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-III HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count I R-III HS" <> 0 THEN
                //  Rec.VALIDATE("Count I R-IV HS",Rec."Count I R-III HS")
                // ELSE
                //  Rec.VALIDATE("Count I R-IV HS",0);

                Rec.VALIDATE("Count I Total HS", Rec."Count I R-I HS" + Rec."Count I R-II HS" + Rec."Count I R-III HS" + Rec."Count I R-IV HS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-III T", Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                IF "Count I R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(37; "Count I R-IV HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-IV HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total HS", Rec."Count I R-I HS" + Rec."Count I R-II HS" + Rec."Count I R-III HS" + Rec."Count I R-IV HS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                IF "Count I R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(38; "Count I Total HS"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Count I R-I DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-I DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count I R-I DS" <> 0 THEN
                //  Rec.VALIDATE("Count I R-II DS",Rec."Count I R-I DS")
                // ELSE
                //  Rec.VALIDATE("Count I R-II DS",0);

                Rec.VALIDATE("Count I Total DS", Rec."Count I R-I DS" + Rec."Count I R-II DS" + Rec."Count I R-III DS" + Rec."Count I R-IV DS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                IF "Count I R-I T" > 101 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(40; "Count I R-II DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-II DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total DS", Rec."Count I R-I DS" + Rec."Count I R-II DS" + Rec."Count I R-III DS" + Rec."Count I R-IV DS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-II T", Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                IF "Count I R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(41; "Count I R-III DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-III DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count I R-III DS" <> 0 THEN
                //  Rec.VALIDATE("Count I R-IV DS",Rec."Count I R-III DS")
                // ELSE
                //  Rec.VALIDATE("Count I R-IV DS",0);

                Rec.VALIDATE("Count I Total DS", Rec."Count I R-I DS" + Rec."Count I R-II DS" + Rec."Count I R-III DS" + Rec."Count I R-IV DS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-III T", Rec."Count I R-III NSL" + Rec."Count I R-III ASL" + Rec."Count I R-III FUG" + Rec."Count I R-III HS" + Rec."Count I R-III DS");
                IF "Count I R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(42; "Count I R-IV DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count I R-IV DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count I Total DS", Rec."Count I R-I DS" + Rec."Count I R-II DS" + Rec."Count I R-III DS" + Rec."Count I R-IV DS");
                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");

                Rec.VALIDATE("Count I R-IV T", Rec."Count I R-IV NSL" + Rec."Count I R-IV ASL" + Rec."Count I R-IV FUG" + Rec."Count I R-IV HS" + Rec."Count I R-IV DS");
                IF "Count I R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(43; "Count I Total DS"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(44; "Count I R-I T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count I Total T", Rec."Count I R-I T" + Rec."Count I R-II T" + Rec."Count I R-III T" + Rec."Count I R-IV T");
            end;
        }
        field(45; "Count I R-II T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count I Total T", Rec."Count I R-I T" + Rec."Count I R-II T" + Rec."Count I R-III T" + Rec."Count I R-IV T");
            end;
        }
        field(46; "Count I R-III T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count I Total T", Rec."Count I R-I T" + Rec."Count I R-II T" + Rec."Count I R-III T" + Rec."Count I R-IV T");
            end;
        }
        field(47; "Count I R-IV T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count I Total T", Rec."Count I R-I T" + Rec."Count I R-II T" + Rec."Count I R-III T" + Rec."Count I R-IV T");
            end;
        }
        field(48; "Count I Total T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; "Count I Result"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;

            trigger OnValidate()
            begin
                Rec."Count I Result Date" := TODAY;
                Rec."Date of Test" := TODAY;
                Rec."Result User Id C-I" := USERID;
                Rec."Final Result User Id" := Rec."Result User Id C-I";
                Rec.Results := Rec."Count I Result";
                IF Rec."Count I Result" = Rec."Count I Result"::Pass THEN
                    Rec.VALIDATE("Subjected to Count II", FALSE)
                ELSE
                    Rec.VALIDATE("Subjected to Count II", TRUE);
            end;
        }
        field(50; "Count I Result Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Count II R-I NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;
                IF "Count II R-I NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-I NSL" <> 0 THEN
                //  Rec.VALIDATE("Count II R-II NSL",Rec."Count II R-I NSL" + 1)
                // ELSE
                //  Rec.VALIDATE("Count II R-II NSL",0);

                Rec.VALIDATE("Count II Total NSL", Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL");

                IF "Count II R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;

                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL") / percentagetobecalculate)
                ELSE
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL"));

                Rec.VALIDATE("Count II R-I T", Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
                IF "Count II R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(52; "Count II R-II NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;
                IF "Count II R-II NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total NSL", Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL");

                IF "Count II R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;

                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL") / percentagetobecalculate)
                ELSE
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL"));

                Rec.VALIDATE("Count II R-II T", Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
                IF "Count II R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(53; "Count II R-III NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;
                IF "Count II R-III NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-III NSL" <> 0 THEN
                //  Rec.VALIDATE("Count II R-IV NSL",Rec."Count II R-III NSL" + 1)
                // ELSE
                //  Rec.VALIDATE("Count II R-IV NSL",0);

                Rec.VALIDATE("Count II Total NSL", Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL");

                IF "Count II R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;

                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL") / percentagetobecalculate)
                ELSE
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL"));

                Rec.VALIDATE("Count II R-III T", Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
                IF "Count II R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(54; "Count II R-IV NSL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                percentagetobecalculate := 0;
                IF "Count II R-IV NSL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total NSL", Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL");

                IF "Count II R-I NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-II NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-III NSL" <> 0 THEN
                    percentagetobecalculate += 1;
                IF "Count II R-IV NSL" <> 0 THEN
                    percentagetobecalculate += 1;

                IF percentagetobecalculate <> 0 THEN
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL") / percentagetobecalculate)
                ELSE
                    Rec.VALIDATE("Count II %", (Rec."Count II R-I NSL" + Rec."Count II R-II NSL" + Rec."Count II R-III NSL" + Rec."Count II R-IV NSL"));

                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
                IF "Count II R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(55; "Count II Total NSL"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "Count II R-I ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-I ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-I ASL" <> 0 THEN
                //  Rec.VALIDATE("Count II R-II ASL",Rec."Count II R-I ASL")
                // ELSE
                //  Rec.VALIDATE("Count II R-II ASL",0);

                Rec.VALIDATE("Count II Total ASL", Rec."Count II R-I ASL" + Rec."Count II R-II ASL" + Rec."Count II R-III ASL" + Rec."Count II R-IV ASL");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-I T", Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
                IF "Count II R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(57; "Count II R-II ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-II ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total ASL", Rec."Count II R-I ASL" + Rec."Count II R-II ASL" + Rec."Count II R-III ASL" + Rec."Count II R-IV ASL");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-II T", Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
                IF "Count II R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(58; "Count II R-III ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-III ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-III ASL" <> 0 THEN
                //  Rec.VALIDATE("Count II R-IV ASL",Rec."Count II R-III ASL")
                // ELSE
                //  Rec.VALIDATE("Count II R-IV ASL",0);

                Rec.VALIDATE("Count II Total ASL", Rec."Count II R-I ASL" + Rec."Count II R-II ASL" + Rec."Count II R-III ASL" + Rec."Count II R-IV ASL");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-III T", Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
                IF "Count II R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(59; "Count II R-IV ASL"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-IV ASL" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total ASL", Rec."Count II R-I ASL" + Rec."Count II R-II ASL" + Rec."Count II R-III ASL" + Rec."Count II R-IV ASL");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
                IF "Count II R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(60; "Count II Total ASL"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(61; "Count II R-I FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-I FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-I FUG" <> 0 THEN
                //  Rec.VALIDATE("Count II R-II FUG",Rec."Count II R-I FUG" - 1)
                // ELSE
                //  Rec.VALIDATE("Count II R-II FUG",0);

                Rec.VALIDATE("Count II Total FUG", Rec."Count II R-I FUG" + Rec."Count II R-II FUG" + Rec."Count II R-III FUG" + Rec."Count II R-IV FUG");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-I T", Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
                IF "Count II R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(62; "Count II R-II FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-II FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total FUG", Rec."Count II R-I FUG" + Rec."Count II R-II FUG" + Rec."Count II R-III FUG" + Rec."Count II R-IV FUG");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-II T", Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
                IF "Count II R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(63; "Count II R-III FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-III FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');

                // IF Rec."Count II R-III FUG" <> 0 THEN
                //  Rec.VALIDATE("Count II R-IV FUG",Rec."Count II R-III FUG" - 1)
                // ELSE
                //  Rec.VALIDATE("Count II R-IV FUG",0);

                Rec.VALIDATE("Count II Total FUG", Rec."Count II R-I FUG" + Rec."Count II R-II FUG" + Rec."Count II R-III FUG" + Rec."Count II R-IV FUG");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-III T", Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
                IF "Count II R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(64; "Count II R-IV FUG"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-IV FUG" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total FUG", Rec."Count II R-I FUG" + Rec."Count II R-II FUG" + Rec."Count II R-III FUG" + Rec."Count II R-IV FUG");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
                IF "Count II R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(65; "Count II Total FUG"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Count II R-I HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-I HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');

                // IF Rec."Count II R-I HS" <> 0 THEN
                //  Rec.VALIDATE("Count II R-II HS",Rec."Count II R-I HS")
                // ELSE
                //  Rec.VALIDATE("Count II R-II HS",0);

                Rec.VALIDATE("Count II Total HS", Rec."Count II R-I HS" + Rec."Count II R-II HS" + Rec."Count II R-III HS" + Rec."Count II R-IV HS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-I T", Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
                IF "Count II R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(67; "Count II R-II HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-II HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total HS", Rec."Count II R-I HS" + Rec."Count II R-II HS" + Rec."Count II R-III HS" + Rec."Count II R-IV HS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-II T", Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
                IF "Count II R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(68; "Count II R-III HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-III HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-III HS" <> 0 THEN
                //  Rec.VALIDATE("Count II R-IV HS",Rec."Count II R-III HS")
                // ELSE
                //  Rec.VALIDATE("Count II R-IV HS",0);

                Rec.VALIDATE("Count II Total HS", Rec."Count II R-I HS" + Rec."Count II R-II HS" + Rec."Count II R-III HS" + Rec."Count II R-IV HS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-III T", Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
                IF "Count II R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(69; "Count II R-IV HS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-IV HS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total HS", Rec."Count II R-I HS" + Rec."Count II R-II HS" + Rec."Count II R-III HS" + Rec."Count II R-IV HS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
                IF "Count II R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(70; "Count II Total HS"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71; "Count II R-I DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-I DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-I DS" <> 0 THEN
                //  Rec.VALIDATE("Count II R-II DS",Rec."Count II R-I DS")
                // ELSE
                //  Rec.VALIDATE("Count II R-II DS",0);

                Rec.VALIDATE("Count II Total DS", Rec."Count II R-I DS" + Rec."Count II R-II DS" + Rec."Count II R-III DS" + Rec."Count II R-IV DS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-I T", Rec."Count II R-I NSL" + Rec."Count II R-I ASL" + Rec."Count II R-I FUG" + Rec."Count II R-I HS" + Rec."Count II R-I DS");
                IF "Count II R-I T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(72; "Count II R-II DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-II DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total DS", Rec."Count II R-I DS" + Rec."Count II R-II DS" + Rec."Count II R-III DS" + Rec."Count II R-IV DS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-II T", Rec."Count II R-II NSL" + Rec."Count II R-II ASL" + Rec."Count II R-II FUG" + Rec."Count II R-II HS" + Rec."Count II R-II DS");
                IF "Count II R-II T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(73; "Count II R-III DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-III DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                // IF Rec."Count II R-III DS" <> 0 THEN
                //  Rec.VALIDATE("Count II R-IV DS",Rec."Count II R-III DS")
                // ELSE
                //  Rec.VALIDATE("Count II R-IV DS",0);

                Rec.VALIDATE("Count II Total DS", Rec."Count II R-I DS" + Rec."Count II R-II DS" + Rec."Count II R-III DS" + Rec."Count II R-IV DS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-III T", Rec."Count II R-III NSL" + Rec."Count II R-III ASL" + Rec."Count II R-III FUG" + Rec."Count II R-III HS" + Rec."Count II R-III DS");
                IF "Count II R-III T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(74; "Count II R-IV DS"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Count II R-IV DS" > 100 THEN
                    ERROR('You cannot enter the value greater than 100');
                Rec.VALIDATE("Count II Total DS", Rec."Count II R-I DS" + Rec."Count II R-II DS" + Rec."Count II R-III DS" + Rec."Count II R-IV DS");
                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");

                Rec.VALIDATE("Count II R-IV T", Rec."Count II R-IV NSL" + Rec."Count II R-IV ASL" + Rec."Count II R-IV FUG" + Rec."Count II R-IV HS" + Rec."Count II R-IV DS");
                IF "Count II R-IV T" > 100 THEN
                    ERROR('Total Cannot be greater than 100');
            end;
        }
        field(75; "Count II Total DS"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(76; "Count II R-I T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count II Total T", Rec."Count II R-I T" + Rec."Count II R-II T" + Rec."Count II R-III T" + Rec."Count II R-IV T");
            end;
        }
        field(77; "Count II R-II T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count II Total T", Rec."Count II R-I T" + Rec."Count II R-II T" + Rec."Count II R-III T" + Rec."Count II R-IV T");
            end;
        }
        field(78; "Count II R-III T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count II Total T", Rec."Count II R-I T" + Rec."Count II R-II T" + Rec."Count II R-III T" + Rec."Count II R-IV T");
            end;
        }
        field(79; "Count II R-IV T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Rec.VALIDATE("Count II Total T", Rec."Count II R-I T" + Rec."Count II R-II T" + Rec."Count II R-III T" + Rec."Count II R-IV T");
            end;
        }
        field(80; "Count II Total T"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(81; "Count II Result"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;

            trigger OnValidate()
            begin
                Rec."Count II Result Date" := TODAY;
                Rec."Date of Test" := TODAY;
                Rec."Result User Id C-II" := USERID;
                Rec."Final Result User Id" := Rec."Result User Id C-II";
                Rec.Results := Rec."Count II Result";
            end;
        }
        field(82; "Count II Result Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(83; "Count I %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                NSLPrcntge := FALSE;
                MaxNSLPrcntge := FALSE;
                /*
                Rec.TESTFIELD("Count I R-I NSL");
                Rec.TESTFIELD("Count I R-II NSL");
                Rec.TESTFIELD("Count I R-III NSL");
                Rec.TESTFIELD("Count I R-IV NSL");
                Rec.TESTFIELD("Count I Total NSL");
                */
                IF Rec."Count I %" <> 0 THEN BEGIN
                    // Codeunit50000.CalculateResult(Rec."Item No.", 21, Rec."Count I %", NSLPrcntge, MaxNSLPrcntge);
                    IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                        Rec.VALIDATE("Count I Result", Rec."Count I Result"::Pass)
                    ELSE
                        Rec.VALIDATE("Count I Result", Rec."Count I Result"::Fail);
                END;

            end;
        }
        field(84; "Count II %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                IF Rec."Count I Result" = Rec."Count I Result"::Fail THEN BEGIN
                    NSLPrcntge := FALSE;
                    MaxNSLPrcntge := FALSE;
                    /*  Rec.TESTFIELD("Count II R-I NSL");
                      Rec.TESTFIELD("Count II R-II NSL");
                      Rec.TESTFIELD("Count II R-III NSL");
                      Rec.TESTFIELD("Count II R-IV NSL");
                      Rec.TESTFIELD("Count II Total NSL");
                    */
                    IF Rec."Count I %" <> 0 THEN BEGIN
                        //  Codeunit50000.CalculateResult(Rec."Item No.", 21, Rec."Count II %", NSLPrcntge, MaxNSLPrcntge);
                        IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                            Rec.VALIDATE("Count II Result", Rec."Count II Result"::Pass)
                        ELSE
                            Rec.VALIDATE("Count II Result", Rec."Count II Result"::Fail);
                    END;
                END;

            end;
        }
        field(85; Invalid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Invalid User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Sample Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Result User Id C-I"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Result User Id C-II"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Final Result User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Foundation Process,Hybrid Process,Organizer Process';
            OptionMembers = " ","Foundation Process","Hybrid Process","Organizer Process";
        }
        field(92; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Item Ledger Entry"."Posting Date" WHERE("Document No." = FIELD("Document No."),
                                                                           "Item No." = FIELD("Item No."),
                                                                           "Crop Code" = FIELD("Crop Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(93; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Bute No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Item Product Group Code"; Code[100])
        {
            CalcFormula = Lookup(Item."Crop Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop';
            Editable = false;
            FieldClass = FlowField;
        }
        field(96; "Item Class of Seeds"; Option)
        {
            CalcFormula = Lookup(Item."Class of Seeds" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Class of Seeds';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(97; "Final Result Posting Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Subjected to Count II"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'For Count II Result';
        }
        field(100; "Received Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Expected Observation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Putting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        recul: Record "User Location";
        recLoc: Record Location;
    begin
        IF "No." = '' THEN BEGIN
            recUL.RESET;
            recUL.SETCURRENTKEY("User ID");
            recUL.SETRANGE("User ID", USERID);
            recUL.SETRANGE("Germination Determination", TRUE);
            IF recUL.FINDFIRST THEN BEGIN
                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                    recLoc.TESTFIELD("GD Series");
                    NoSeriesMgt.InitSeries(recLoc."GD Series", xRec."No. Series", 0D, "No.", "No. Series");
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("GD Series"));
            END ELSE
                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
        END;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recUL: Record 50015;
        recLoc: Record 14;
        NSLPrcntge: Boolean;
        Codeunit50000: Codeunit 50000;
        MaxNSLPrcntge: Boolean;
        percentagetobecalculate: Decimal;
}

