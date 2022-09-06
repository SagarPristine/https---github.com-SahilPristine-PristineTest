pageextension 50113 Customercard extends "Customer Card"
{
    layout
    {
        addafter("Post Code")
        {

            field(Zone; Rec.Zone)
            {
                ToolTip = 'Specifies the value of the Zone field.';
                ApplicationArea = All;
            }
            field("Zone Name"; Rec."Zone Name")
            {
                ToolTip = 'Specifies the value of the Zone Name field.';
                ApplicationArea = All;
            }
            field(District; Rec.District)
            {
                ToolTip = 'Specifies the value of the District field.';
                ApplicationArea = All;
            }
            field("District Name"; Rec."District Name")
            {
                ToolTip = 'Specifies the value of the District Name field.';
                ApplicationArea = All;
            }

        }
        addafter(ContactName)
        {
            field(Region; Rec.Region)
            {
                ToolTip = 'Specifies the value of the Region field.';
                ApplicationArea = All;
            }
            field("Region Name"; Rec."Region Name")
            {
                ToolTip = 'Specifies the value of the Region Name field.';
                ApplicationArea = All;
            }
            field(Taluka; Rec.Taluka)
            {
                ToolTip = 'Specifies the value of the Taluka field.';
                ApplicationArea = All;
            }
            field("Taluka Name"; Rec."Taluka Name")
            {
                ToolTip = 'Specifies the value of the Taluka Name field.';
                ApplicationArea = All;
            }
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Type field.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}