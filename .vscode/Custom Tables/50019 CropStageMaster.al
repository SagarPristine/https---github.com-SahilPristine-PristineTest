table 50019 "Crop Stage Master"
{
    LookupPageID = "Crop Stage Master List";

    fields
    {
        field(1; "Crop Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Crop Master".Code;
        }
        field(2; Stage; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Lint/Remenant"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Lint,Remenant';
            OptionMembers = " ",Lint,Remenant;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; GOT; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; BT; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Germination Determination"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Blend Allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Physical Purity Determination"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Moisture Determination"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Vigour Test"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; NAOH; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; EC; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Chlorophyll Test"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; AAT; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "HT Herbicide tolerance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Soil emergence"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Phenol Test"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Crop Code", Stage, Sequence)
        {
            Clustered = true;
        }
        key(Key2; "Crop Code", Sequence)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Crop Code", Stage)
        {
        }
    }
}

