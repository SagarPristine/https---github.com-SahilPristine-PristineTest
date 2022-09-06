tableextension 50063 CustomerExtension extends Customer
{
    fields
    {
        field(50000; Zone; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Zone Master".Code;
        }
        field(50001; District; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "District Master".Code;
        }
        field(50002; Region; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Region Master".Code;
        }
        field(50003; Taluka; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Taluka Master".Code;
        }
        field(50004; "Customer Type"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Customer,Organizer,Grower,Supplier,Transporter,Contractor,Other,Dealer,Distributor;
        }
        field(50005; "Zone Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Zone Master".Description where(Code = field(Zone)));
        }
        field(50006; "Taluka Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Taluka Master".Description where(Code = field(Taluka)));
        }
        field(50007; "Region Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Region Master".Name where(Code = field(Region)));
        }
        field(50008; "District Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("District Master".Name where(Code = field(District)));
        }
        field(50009; "Is party"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Vendor Type"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Vendor,Organizer,Grower,Supplier,Transporter,Contractor,Other,Dealer,Distributor;
        }

    }


    var
        myInt: Integer;
}