table 50014 "Process Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Crop Code"; Code[50])
        {
            Caption = 'Crop Code';
            DataClassification = ToBeClassified;
            TableRelation = "Crop Master".Code;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No." WHERE("Crop Code" = FIELD("Crop Code"));

            trigger OnValidate()
            var
                rec5401: Record 5401;
            begin
                "Created By" := USERID;
            end;
        }
        field(5; "From Stage"; Code[50])
        {
            Caption = 'From Stage';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                rec32: Record 32;
                rec50008: Record 50008;
                rec7302: Record 7302;
                integr: Integer;
                Trec50008: Record 50017;
                rec50001: Record "Crop Stage Master";
                Trec50001: Record "Crop Stage Master";
                CompanyInfo: Record 79;
                rec27: Record 27;
            // QCResultDeclaration: Record 50032;
            // "----------------fetching sample code for other than raw---------------": Integer;
            // recGot: Record 50022;
            begin
                //Updating Process Transfer Line Value
                IF Rec.Location = '' THEN
                    ERROR('Please select Location first.');


                //For To Stage
                rec50001.RESET;
                rec50001.SETCURRENTKEY("Crop Code", Stage);
                rec50001.SETRANGE("Crop Code", Rec."Crop Code");
                rec50001.SETRANGE(Stage, Rec."From Stage");
                IF rec50001.FINDFIRST THEN BEGIN
                    Trec50001.RESET;
                    Trec50001.SETCURRENTKEY("Crop Code", Sequence);
                    Trec50001.SETRANGE("Crop Code", Rec."Crop Code");
                    Trec50001.SETRANGE(Sequence, rec50001.Sequence + 1);
                    IF Trec50001.FINDFIRST THEN
                        Rec."To Stage" := Trec50001.Stage;
                END;

                //When Item No. is Blank
                IF Rec."From Stage" = '' THEN BEGIN
                    Rec."To Stage" := '';
                    Trec50008.RESET;
                    Trec50008.SETCURRENTKEY("Document No.");
                    Trec50008.SETRANGE("Document No.", Rec."No.");
                    IF Trec50008.FINDSET THEN
                        Trec50008.DELETEALL;
                END;
            end;
        }
        field(6; "To Stage"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Location; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

            trigger OnValidate()
            var
                ProcessTransferPostYesNo: Codeunit 50000;
            begin

            end;
        }
        field(8; Season; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";
        }
        field(9; Shift; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Day,Night';
            OptionMembers = Day,Night;
        }
        field(10; "Starting DateTime"; DateTime)
        {
            Caption = 'Starting Time';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                IF "Ending DateTime" <> 0DT THEN BEGIN
                    IF "Starting DateTime" > "Ending DateTime" THEN
                        ERROR('Start DateTime must be less than End Date Time');
                END;
            end;
        }
        field(11; "Ending DateTime"; DateTime)
        {
            Caption = 'Ending Time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Ending DateTime" <> 0DT THEN BEGIN
                    TESTFIELD("Starting DateTime");
                    IF "Ending DateTime" < "Starting DateTime" THEN
                        ERROR('End DateTime must be greater than Start Date Time');
                END;
            end;
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Complete';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Complete;
        }
        field(16; "Sample Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Machine No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Location Name"; Text[100])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD(Location)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Item Product Group Code"; Code[100])
        {
            CalcFormula = Lookup(Item."Crop Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Class of Seeds"; Option)
        {
            CalcFormula = Lookup(Item."Class of Seeds" WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(22; "Item Category Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Crop Category';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Code;
        }
        field(24; Contractor; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE("Vendor Type" = CONST(Contractor));
        }
        field(25; "Contractor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD(Contractor)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; Supervisor; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." WHERE("Job Title" = FILTER('Processing'));
        }
        field(27; "Supervisor Name"; Code[50])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD(Supervisor)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Machine No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource."No." WHERE(Type = FILTER(Machine));

            trigger OnValidate()
            var
                Resourcerec: Record 156;
            begin
                Resourcerec.RESET;
                Resourcerec.GET("Machine No");
                "Machine Name" := "Machine No";
            end;
        }
        field(31; "Machine Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Screen No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource WHERE(Type = FILTER(Screen));

            trigger OnValidate()
            begin
                ResourceRec.RESET;
                ResourceRec.GET("Screen No");
                "Screen Name" := ResourceRec.Name;
            end;
        }
        field(33; "Screen Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Created By"; Code[50])
        {
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                recUL.SETRANGE("User ID", USERID);
                IF recUL.FINDFIRST THEN
                    "Created By" := USERID;
            end;
        }
        field(36; "Approver Id"; Code[50])
        {
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(37; "Creation Date Time"; DateTime)
        {
        }
        field(38; "Rejected Date Time"; DateTime)
        {
        }
        field(39; "Sent Approval Date Time"; DateTime)
        {
        }
        field(40; "Bute No."; Code[30])
        {
            CalcFormula = Lookup("Process Line"."From Bute No." WHERE("Document No." = FIELD("No.")));
            Caption = 'Lot No.';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                rec50007: Record 50007;
                rec32: Record 32;
                InventorySetup: Record 313;
                ProcessLine: Record 50008;
            begin
            end;
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
    begin
        IF "No." = '' THEN BEGIN
            IF Location <> '' THEN BEGIN
                IF recLoc.GET(Location) THEN BEGIN
                    recLoc.TESTFIELD("Pre Process Transfer No.");
                    NoSeriesMgt.InitSeries(recLoc."Pre Process Transfer No.", xRec."No. Series", 0D, "No.", "No. Series");
                    Rec.Location := Location;
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Pre Process Transfer No."));
            END;
        END;
    END;


    var
        PurchSetup: Record 312;
        NoSeriesMgt: Codeunit 396;
        recUL: Record 50018;
        recLoc: Record 14;
        ProgWindow: Dialog;
        RecItem: Record 27;
        RecPRoL: Record 50008;
        ResourceRec: Record 156;

    procedure CalculateBom(RecOutsideHeader: Record "Process Header")
    var
        RecLine: Record "Process Line";
        ProdBomLine: Record "BOM Component";
        LineNo: Integer;
        RecLine2: Record "Process Line";
        Item: Record 27;
        Item2: Record 27;
    begin

        RecLine.RESET;
        RecLine.SETRANGE("Document No.", RecOutsideHeader."No.");
        RecLine.SETRANGE("Entry Type", RecLine."Entry Type"::Output);
        RecLine.MODIFYALL("Complete Bom Calculation", FALSE);

        RecLine2.RESET;
        RecLine2.SETRANGE("Document No.", RecOutsideHeader."No.");
        RecLine2.SETRANGE("Entry Type", RecLine2."Entry Type"::Consumption);
        RecLine2.DELETEALL;

        Item.GET(RecOutsideHeader."Item No.");
        Item.CalcFields("Assembly BOM");
        IF Item."Assembly BOM" = false THEN
            ERROR('No BOM Componenet is defined for %1 this item!', RecOutsideHeader."Item No.");

        RecLine.RESET;
        RecLine.SETRANGE("Document No.", RecOutsideHeader."No.");
        RecLine.SETRANGE("Entry Type", RecLine."Entry Type"::Output);
        RecLine.SETRANGE("Complete Bom Calculation", FALSE);
        IF RecLine.FINDSET THEN BEGIN
            REPEAT
                recline.TestField("Good Qty.");
                ProdBomLine.RESET;
                ProdBomLine.SETRANGE(ProdBomLine."Parent Item No.", RecOutsideHeader."Item No.");
                ProdBomLine.SETRANGE(ProdBomLine.Stage, RecOutsideHeader."To Stage");
                IF ProdBomLine.FINDFIRST THEN BEGIN
                    REPEAT
                        RecLine2.RESET;
                        RecLine2.SETRANGE("Document No.", RecOutsideHeader."No.");
                        IF RecLine2.FINDLAST THEN
                            LineNo := RecLine2."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        RecLine2.RESET;
                        RecLine2.INIT;
                        RecLine2."Document No." := RecOutsideHeader."No.";
                        RecLine2."Line No." := LineNo;
                        RecLine2."Entry Type" := RecLine."Entry Type"::Consumption;
                        RecLine2."Consumption Line No" := RecLine."Line No.";
                        Item2.GET(ProdBomLine."No.");
                        RecLine2.Description := Item2.Description;
                        RecLine2.VALIDATE("Item No.", ProdBomLine."No.");
                        RecLine2.VALIDATE("Unit of Measure Code", ProdBomLine."Unit of Measure Code");
                        IF RecOutsideHeader."To Stage" = 'PACKED' THEN
                            RecLine2."Total Avai. Qty." := ROUND((RecLine."Good Qty." + RecLine."Sample Qty.") * ProdBomLine."Quantity per", 1, '=')
                        ELSE
                            RecLine2."Total Avai. Qty." := ((RecLine."Good Qty." + RecLine."Sample Qty.") * ProdBomLine."Quantity per");
                        RecLine2.INSERT;
                    UNTIL ProdBomLine.NEXT = 0;
                END;
                RecLine."Complete Bom Calculation" := TRUE;
                RecLine.MODIFY(TRUE);
            UNTIL RecLine.NEXT = 0;
            Message('The Consumption');
        END;
    end;
}

