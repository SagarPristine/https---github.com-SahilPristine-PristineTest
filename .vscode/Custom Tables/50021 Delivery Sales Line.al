table 50021 "Delivery Sales line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Crop Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Crop Master".Code;
        }
        field(4; "Class of Seeds"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(5; "Variety Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Varieties."Variety Code";
        }
        field(6; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." where("Crop Code" = field("Crop Code"));
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item No.") then begin
                    "Item Name" := Item.Description;
                    "Variety Code" := Item."Variety Code";
                    "Class of Seeds" := Item."Class of Seeds";
                    "FG Pack Size" := Item."FG Pack Size";
                    "Unit of Measure" := Item."Sales Unit of Measure";
                    "Variant Code" := 'PACKED';
                end
                else begin
                    "Item Name" := '';
                    "Variety Code" := '';
                    "Class of Seeds" := "Class of Seeds"::" ";
                    "FG Pack Size" := 0;
                    "Unit of Measure" := '';
                    "Variant Code" := '';
                end;
            end;
        }
        field(7; "Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Unit of Measure".Code;
        }

        field(9; "FG Pack Size"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(10; "No. of bags"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            trigger OnValidate()
            begin

                if "No. of bags" <> 0 then
                    Quantity := "FG Pack Size" * "No. of bags"
                else
                    Quantity := 0;

            end;
        }

        field(11; "Variant Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }

        field(12; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Qty Allocated in Dc"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Shipped Qty"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}