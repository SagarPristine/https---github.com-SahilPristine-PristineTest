table 50015 "Process Invoice Header"
{

    fields
    {
        field(1; "Process Transfer Pre No."; Code[20])
        {
            Caption = 'Process Transfer Pre No.';
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
            TableRelation = Item."No.";

        }
        field(5; "From Stage"; Code[50])
        {
            Caption = 'From Stage';
            DataClassification = ToBeClassified;
        }
        field(6; "To Stage"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Location; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
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
        }
        field(11; "Ending DateTime"; DateTime)
        {
            Caption = 'Ending Time';
            DataClassification = ToBeClassified;
        }
        field(12; "Pre-Assigned No. Series"; Code[20])
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
        field(14; "Process Transfer Post No."; Code[20])
        {
            Caption = 'Process Transfer Post No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                recul: Record "User Location";
                recLoc: Record Location;
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                IF "Process Transfer Post No." <> xRec."Process Transfer Post No." THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE("Process Invoice Header", TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("Post Process Transfer No.");
                            NoSeriesMgt.TestManual(recLoc."Post Process Transfer No.");
                            "No. Series" := '';
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Post Process Transfer No."));
                    END ELSE
                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                END;
            end;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
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
        // field(20; "Item Product Group Code"; Code[20])
        // {
        //     CalcFormula = Lookup(Item."Product Group Code" WHERE(No.=FIELD(Item No.)));
        //     Caption = 'Item Crop';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Product Group".Code WHERE (Item Category Code=FIELD(Item Category Code));
        // }
        field(21; "Item Class of Seeds"; Option)
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
            TableRelation = Employee."No.";
        }
        field(27; "Supervisor Name"; Code[30])
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
            DataClassification = ToBeClassified;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(36; "Approver Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(37; "Creation Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Rejected Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Sent Approval Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Bute No."; Code[30])
        {
            //     CalcFormula = Lookup("Process Invoice Line"."From Bute No." WHERE(Post Document No.=FIELD(Process Transfer Post No.)));
            //         Caption = 'Lot No.';
            //         FieldClass = FlowField;

            //     trigger OnValidate()
            //     var
            //         rec50007: Record "50007";
            //         rec32: Record "32";
            //         InventorySetup: Record "313";
            //         ProcessLine: Record "50008";
            //     begin
            //     end;
        }
        field(41; "Working Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Purchase/Sales Return/ Stock transfer intake,Online,Offline,Dispatch/Pur Return,Manual,Godown2Godown transfer,Stack to Stack transfer through vehicle,Stack to Stack transfer w/o vehicle,Packing Machine cleaning,Grading Unit cleaning,To cover the stack & remove the stack,own location/Stock Transfer,Male,Female,All type non seed material,Loading & unloading,G2G transfer through vehicle,G2G transfer w/o vehicle';
            OptionMembers = " ","Purchase/Sales Return/ Stock transfer intake",Online,Offline,"Dispatch/Pur Return",Manual,"Godown2Godown transfer","Stack to Stack transfer through vehicle","Stack to Stack transfer w/o vehicle","Packing Machine cleaning","Grading Unit cleaning","To cover the stack & remove the stack","own location/Stock Transfer",Male,Female,"All type non seed material","Loading & unloading","G2G transfer through vehicle","G2G transfer w/o vehicle";
        }
    }

    keys
    {
        key(Key1; "Process Transfer Post No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Process Transfer Post No." = '' THEN BEGIN
            recUL.RESET;
            recUL.SETCURRENTKEY("User ID");
            recUL.SETRANGE("User ID", USERID);
            recUL.SETRANGE("Process Invoice Header", TRUE);
            IF recUL.FINDFIRST THEN BEGIN
                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                    recLoc.TESTFIELD("Post Process Transfer No.");
                    NoSeriesMgt.InitSeries(recLoc."Post Process Transfer No.", xRec."No. Series", 0D, "Process Transfer Post No.", "No. Series");
                END ELSE
                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Post Process Transfer No."));
            END ELSE
                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
        END;
    end;

    var
        PurchSetup: Record 312;
        NoSeriesMgt: Codeunit 396;
        recUL: Record 50018;
        recLoc: Record 14;
        ResourceRec: Record 156;
}

