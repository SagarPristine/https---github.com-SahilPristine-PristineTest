table 50004 "Varieties"
{
    LookupPageID = Varieties;

    fields
    {
        field(1; "Variety Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(4; "Class of Seeds"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(5; Duration; Decimal)
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Key1; "Variety Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Variety Code", "Class of Seeds")
        {
        }
        fieldgroup(Brick; "Variety Code", "Class of Seeds")
        {

        }
    }

    trigger OnInsert()
    begin

    end;

    var

}


