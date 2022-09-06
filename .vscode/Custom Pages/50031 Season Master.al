page 50031 "Season Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Season Master";
    SourceTableView = sorting("Season Code", Sequence) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Season Code"; rec."Season Code")
                {
                    ApplicationArea = All;

                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = all;
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