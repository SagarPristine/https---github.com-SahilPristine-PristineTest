tableextension 50069 ItemLedgerEnrty extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Crop Code"; Code[50])
        {
            DataClassification = ToBeClassified;

            TableRelation = "Crop Master".Code;
        }
        field(50001; "Class of Seeds"; Option)
        {
            DataClassification = ToBeClassified;

            OptionCaption = ' ,Breeder,Foundation,TL,Tissue Culture';
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
        }
        field(50002; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;

            OptionCaption = ' ,Seeds,Non Seeds,Consumable,Stock Culture,Hardened plants';
            OptionMembers = " ",Seeds,"Non Seeds",Consumable,"Stock Culture","Hardened plants";
        }
        field(50003; "FG Pack Size"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

        }
        field(50004; "Production Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50005; "Marketing Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50006; "Variety Code"; Code[50])
        {
            DataClassification = ToBeClassified;

            TableRelation = Varieties."Variety Code";
        }
        field(50007; "No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50008; "Loss Type"; Option)
        {
            DataClassification = ToBeClassified;

            OptionCaption = ' ,Processing Loss,Packing Loss,Lint Loss,Remenant Loss,Good,Excess Loss,Field Reject,Sample Loss,Moisture Loss,Inert Loss,No Loss,Qc Sample Rec,Qc Sample Transfer,QA Tested sample,Contamination,Blending,RIB,Non Seed Loss';
            OptionMembers = " ","Processing Loss","Packing Loss","Lint Loss","Remenant Loss",Good,"Excess Loss","Field Reject","Sample Loss","Moisture Loss","Inert Loss","No Loss","Qc Sample Rec","Qc Sample Transfer","QA Tested sample",Contamination,Blending,RIB,"Non Seed Loss";
        }
        field(50009; "Season Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";
        }
        field(50010; "Land in Acre"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Crop Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = '//Manoj@PBS';
            OptionCaption = ' ,Hybrid,Improved,Inbred,Tissue Culture,Non Hybrid,Notified,Hybrid-Notified,Research,Research Hybrid,Certified';
            OptionMembers = " ",Hybrid,Improved,Inbred,"Tissue Culture","Non Hybrid",Notified,"Hybrid-Notified",Research,"Research Hybrid",Certified;
        }
        field(50012; "Hybrid Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = '//Manoj@PBS';
            OptionCaption = ' ,Research,Certified,Notified,Production,Truthful,Premium';
            OptionMembers = " ",Research,Certified,Notified,Production,Truthful,Premium;
        }
        field(50013; "Item Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50014; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//Non seed & tissue culture';
        }
        field(50015; "Packing By"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Quality Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; RVD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "No. of Bottles"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50019; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Non seed & tissue culture';
        }
        field(50020; Blended; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Location Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Location Code")));
            Editable = false;

        }

        field(50023; RIB; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(50025; "No. of Packages"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50026; Manufacturer; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50027; "Mfg. Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50028; "Inventory Type"; Enum "Inventory Type")
        {
            DataClassification = ToBeClassified;
        }


    }

    var
        myInt: Integer;
}