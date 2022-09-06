pageextension 50120 PostedSalesShipments extends "Posted Sales Shipments"
{
    layout
    {

        addbefore("Sell-to Customer No.")
        {
            field("Document SubType"; Rec."Document SubType")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document SubType field.';
            }

            field("Delivery Order No"; Rec."Delivery Order No")
            {
                ToolTip = 'Specifies the value of the Delivery Order No field.';
                ApplicationArea = All;
            }

        }
        addafter("Sell-to Country/Region Code")
        {
            field(Season; Rec.Season)
            {
                ToolTip = 'Specifies the value of the Season field.';
                ApplicationArea = All;
            }

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

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}