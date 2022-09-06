page 50062 "Vegetative Roughing Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER("Vegetative Roughing"));

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
                field("Sowing Area in Acres"; Rec."Sowing Area in Acres")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sowing Area in Acres field.';
                }
                field("Date of sowing Male"; Rec."Date of sowing Male")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of sowing Male field.';
                }
                field("Date of sowing Female"; Rec."Date of sowing Female")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of sowing Female field.';
                }
                field("Date of visit"; Rec."Date of visit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of visit field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
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

