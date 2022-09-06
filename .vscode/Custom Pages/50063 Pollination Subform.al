page 50063 "Pollination Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER(Pollination));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Production Lot No."; rec."Production Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Organizer/Co-ordinator Name"; rec."Organizer Code")
                {
                    Caption = 'Organizer/Co-ordinator Name';
                    ApplicationArea = all;
                }
                field("Grower/Land Owner Name"; rec."Grower/Land Owner Name")
                {
                    ApplicationArea = all;
                }
                field("Grower Village"; rec."Grower Village")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = all;
                }
                field("Crop Code"; rec."Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Item Class of Seeds"; rec."Item Class of Seeds")
                {
                    ApplicationArea = all;
                }
                field("Item Crop Type"; rec."Item Crop Type")
                {
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                    trigger OnValidate()
                    begin
                        rec."No. of Days" := rec."Pollination Complete Date" - rec."Start Date";
                    end;
                }
                field("Pollination Complete Date"; Rec."Pollination Complete Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pollination Complete Date field.';
                    trigger OnValidate()
                    begin
                        Rec.TestField("Start Date");
                        rec."No. of Days" := rec."Pollination Complete Date" - rec."Start Date";
                    end;
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Days field.';
                }

                field("Time isolation"; Rec."Time isolation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time isolation field.';
                }
                field("Nick Status"; Rec."Nick Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nick Status field.';
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
    end;

    trigger OnAfterGetRecord()
    begin
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit 99000832;
    begin
    end;

    trigger OnOpenPage()
    var
    begin
    end;

    var

}

