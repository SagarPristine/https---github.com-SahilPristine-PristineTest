page 50033 "Varieties"
{
    PageType = List;
    SourceTable = Varieties;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Variety Code"; REc."Variety Code")
                {
                    ApplicationArea = all;
                }
                field("Class of Seeds"; REC."Class of Seeds")
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

