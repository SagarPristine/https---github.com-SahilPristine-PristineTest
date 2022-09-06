page 50040 "Production Plan"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Production Plan Header";



    layout
    {
        area(Content)
        {
            grid(General)

            {


                field("Production Plan No."; Rec."Production Plan No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Enabled = Rec."Production Plan No." = '';

                }
                field(Season; rec.Season)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Enabled = Rec.Season = '';

                }

            }
            part(ProductionLine; "Production Plan Subform")

            {
                ApplicationArea = all;
                SubPageLink = "Production Plan No." = FIELD("Production Plan No."), Season = field(Season);
                SubPageView = SORTING("Production Plan No.", Season, "Line No.");
                Visible = rec.Season <> '';

            }
        }


    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Planning Worksheet")
    //         {
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 ProductionPlanWorksheet: Page "Production Plan Worksheet";
    //                 ProductionPlanLine: Record "Production Plan Line";
    //             begin
    //                 ProductionPlanLine.Reset();
    //                 ProductionPlanLine.SetRange("Production Plan No.", Rec."Production Plan No.");
    //                 ProductionPlanLine.FindFirst();
    //                 ProductionPlanWorksheet.SetTableView(ProductionPlanLine);
    //                 //ProductionPlanWorksheet.SetValues(Rec);
    //                 ProductionPlanWorksheet.RunModal();
    //             end;
    //         }
    //     }
    // }

    var
        myInt: Integer;
    // PageSubform: Page "Production Plan Worksheet";
}