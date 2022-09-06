tableextension 50112 "Item Templ Extension" extends 1382
{
    fields
    {
        field(50001; "Class of Seeds"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(50002; "FG Pack Size"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Crop Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Seeds","Non Seeds";
        }
        field(50005; "Hybrid Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Research","Certified","Notified","Production";
        }
        field(50006; "Crop Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Hybrid","Improved","Inbred","Tissue Culture";
        }
        field(50007; "Variety Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Varieties;
        }
        field(50008; "Male/Female"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Male,Female;
        }

    }

    var
        myInt: Integer;
}