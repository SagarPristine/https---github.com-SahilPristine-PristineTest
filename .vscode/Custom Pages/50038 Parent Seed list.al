page 50038 "Parent Seed List"
{
    ApplicationArea = all;
    CardPageID = "Parent Seed Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Parent Seed Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Variety Type"; REC."Variety Type")
                {
                    ApplicationArea = all;
                }
                field("Variety Code"; REC."Variety Code")
                {
                    ApplicationArea = all;
                }
                field("Sequence No"; REC."Sequence No")
                {
                    ApplicationArea = all;
                }
                field("Variety Name"; REC."Variety Name")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Code(Male)"; REC."Parent Seed Code(Male)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Name(Male)"; REC."Parent Seed Name(Male)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Code(Female)"; REC."Parent Seed Code(Female)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Name(Female)"; REC."Parent Seed Name(Female)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Code(Other)"; REC."Parent Seed Code(Other)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Name(Other)"; REC."Parent Seed Name(Other)")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin

    end;

    var

}

