page 50054 "Delivery Sales Card"
{
    PageType = Document;
    UsageCategory = None;
    RefreshOnActivate = true;
    SourceTable = "Delivery Sales Header";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Marketing indent No."; Rec."Marketing indent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketing indent No. field.';
                }
                field("Document SybType"; Rec."Document SybType")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document SybType field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
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
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the State Code field.';
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
                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Season field.';
                }

                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Child Seed Type"; Rec."Child Seed Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Child Seed Type field.';
                }
                field("Child Seed"; Rec."Child Seed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Child Seed field.';
                }

            }
            part("Subform"; "Delivery Sales Subform")
            {
                ApplicationArea = all;
                Caption = 'Delivery Sales Subform';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Release)
            {
                Caption = 'Release';
                Ellipsis = true;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ApplicationArea = all;

                trigger OnAction()
                begin
                    rec.TestField(Status, rec.Status::Open);
                    if Confirm('Do you want to release the document ?', true) then
                        Rec.Status := Rec.Status::Released;

                end;
            }
        }
    }

    var
        myInt: Integer;
}