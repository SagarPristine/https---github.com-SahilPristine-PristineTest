table 50009 "Parent Seed Master"
{
    LookupPageID = "Parent Seed List";

    fields
    {
        field(1; "Variety Type"; Option)
        {
            OptionMembers = " ",Breeder,Foundation,Hybrid,Improved,Germplasm,Planting;
        }
        field(2; "Variety Code"; Code[20])
        {
            TableRelation = Item."No." WHERE("Item Type" = FILTER(Seeds));

            trigger OnValidate()
            begin

                Item.Reset;
                if Item.Get("Variety Code") then
                    "Variety Name" := Item.Description
                else
                    "Variety Name" := '';

            end;
        }
        field(3; "Variety Name"; Text[30])
        {
            Editable = false;
            TableRelation = Item.Description WHERE("No." = FIELD("Variety Code"));
            ValidateTableRelation = false;
        }
        field(4; "Parent Seed Code(Male)"; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin

                Item.Reset;
                if Item.Get("Parent Seed Code(Male)") then
                    "Parent Seed Name(Male)" := Item.Description
                else
                    "Parent Seed Name(Male)" := '';

            end;
        }
        field(5; "Parent Seed Name(Male)"; Text[30])
        {
            Editable = false;
        }
        field(6; "Parent Seed Code(Female)"; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                Item.Reset;
                if Item.Get("Parent Seed Code(Female)") then
                    "Parent Seed Name(Female)" := Item.Description
                else
                    "Parent Seed Name(Female)" := '';

            end;
        }
        field(7; "Parent Seed Name(Female)"; Text[30])
        {
            Editable = false;
        }
        field(8; Description; Text[120])
        {
        }
        field(9; "Parent Seed Code(Other)"; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                Item.Reset;
                if Item.Get("Parent Seed Code(Other)") then
                    "Parent Seed Name(Other)" := Item.Description
                else
                    "Parent Seed Name(Other)" := '';

            end;
        }
        field(10; "Parent Seed Name(Other)"; Text[30])
        {
            Editable = false;
        }

        field(12; "Variety Crop Code"; Code[250])
        {
            CalcFormula = Lookup(Item."Crop Code" WHERE("No." = FIELD("Variety Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Sequence No"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//LK';
        }
    }

    keys
    {
        key(Key1; "Variety Type", "Variety Code", "Sequence No")
        {
            Clustered = true;
        }
        key(Key2; "Variety Code", "Variety Name", "Parent Seed Name(Male)", "Parent Seed Name(Female)", "Parent Seed Name(Other)")
        {
        }
        key(Key3; "Variety Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Variety Code", "Variety Name")
        {
        }
    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        Item: Record Item;
        desc: Text[120];
}

