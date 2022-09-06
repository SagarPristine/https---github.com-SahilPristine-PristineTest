tableextension 50068 Location extends Location
{
    fields
    {

        field(50000; "Pre Process Transfer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(50001; "Post Process Transfer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50002; "Got Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(50003; "GD Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50004; "PPD Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(50005; "QC Result Declara. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(50006; "VT Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(50007; "Delivery Order No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(50008; "Planting No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50009; "Nursery No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50010; "Vegetative No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50011; "Isolation No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50012; "Pre Flowering Roug. No. Series"; Code[20])
        {
            Caption = 'Pre Flowering Roughing No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50013; "Flowering Roughing No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50014; "MaleChoping No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50015; "Final Roughing No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50016; "Harvesting No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50017; "Pollination No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50018; "Vegetative Roughing No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }

    }

    var
        myInt: Integer;
}