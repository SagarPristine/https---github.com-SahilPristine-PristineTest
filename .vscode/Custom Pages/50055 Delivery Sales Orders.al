page 50055 "Delivery Sales Orders"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Delivery Sales Header";
    CardPageId = "Delivery Sales Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Marketing indent No."; Rec."Marketing indent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketing indent No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Address field.';
                }
                field("Sell-to address 2"; Rec."Sell-to address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to address 2 field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field(Zone; Rec.Zone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zone field.';
                }
                field("Zone Name"; Rec."Zone Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zone Name field.';
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District field.';
                }
                field("District Name"; Rec."District Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District Name field.';
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field("Region Name"; Rec."Region Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Region Name field.';
                }
                field(Taluka; Rec.Taluka)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Taluka field.';
                }
                field("Taluka Name"; Rec."Taluka Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Taluka Name field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Date field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Season field.';
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}