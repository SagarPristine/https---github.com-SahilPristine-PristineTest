page 50080 "Inspection Subform 4"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER("Pre Flowering Roughing"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Types of OT"; Rec."Types of OT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Types of OT field.';
                }
                field("No. of OT in 1000 Hill"; Rec."No. of OT in 1000 Hill")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of OT in 1000 Hill field.';
                }
                field("Planned Date"; Rec."Planned Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Date field.';
                }
                field("Production Lot No."; rec."Production Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Organizer/Co-ordinator Name"; rec."Organizer Code")
                {
                    ApplicationArea = all;
                    Caption = 'Organizer/Co-ordinator Name';
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
                field("Preflowering Roughing Completion Date"; Rec."Preflowering Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preflowering Roughing Completion Date field.';
                    Caption = 'Preflowering Roughing Completion Date';
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

    trigger OnDeleteRecord(): Boolean
    var
    begin
    end;

    var

}

