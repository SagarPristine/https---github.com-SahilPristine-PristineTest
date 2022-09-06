pageextension 50114 SalesOrder extends "Sales Order"
{
    layout
    {

        addbefore("Sell-to Customer No.")
        {
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
        addafter(General)
        {
            group(Transportation)
            {

                field("Transporter Code"; Rec."Transporter Code")
                {
                    ToolTip = 'Specifies the value of the Transporter Code field.';
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ToolTip = 'Specifies the value of the Transporter Name field.';
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                    ApplicationArea = All;
                }
                field("Driver Phone"; Rec."Driver Phone")
                {
                    ToolTip = 'Specifies the value of the Driver Phone field.';
                    ApplicationArea = All;

                }
                field("Paid by Party"; Rec."Paid by Party")
                {
                    ToolTip = 'Specifies the value of the Paid by Party field.';
                    ApplicationArea = All;
                }
                field("Balance Amount"; Rec."Balance Amount")
                {
                    ToolTip = 'Specifies the value of the Balance Amount field.';
                    ApplicationArea = All;
                }
                field("Freight Term"; Rec."Freight Term")
                {
                    ToolTip = 'Specifies the value of the Freight Term field.';
                    ApplicationArea = All;
                }
                field("Freight Amount"; Rec."Freight Amount")
                {
                    ToolTip = 'Specifies the value of the Freight Amount field.';
                    ApplicationArea = All;
                }
                field("Advance Amount"; Rec."Advance Amount")
                {
                    ToolTip = 'Specifies the value of the Advance Amount field.';
                    ApplicationArea = All;
                }

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