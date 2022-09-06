#pragma warning disable
page 50045 "Location Wise Prod. Dist."
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Location Wise Prod. Dist.";
    Caption = 'Location Wise Distribution';

    layout
    {
        area(Content)
        {
            // grid(Summary)

            // {
            //     field("Total PS Required"; TotalPSRequired)
            //     {
            //         ApplicationArea = all;
            //         CaptionClass = '1,5,,' + Dynamiccolumn1;
            //         Style = Unfavorable;
            //         Editable = false;

            //     }

            // }
            cuegroup(Totals)
            {
                CuegroupLayout = Wide;
                ShowCaption = false;

                field("Total PS Required"; TotalPSRequired)
                {
                    ApplicationArea = all;
                    Caption = 'Total PS Required';
                    Editable = false;
                    ToolTip = 'It is showing the sum of the Ps required for distribution';
                    trigger OnDrillDown()
                    begin

                    end;

                }
                field("Expected Raw Target"; TotalExpectedRawTarget)
                {
                    ApplicationArea = all;
                    Caption = 'Expected Raw Target';
                    Editable = false;
                    ToolTip = 'It is showing the sum of the Raw Production required assuming 67% Risk';
                    Style = Unfavorable;
                    trigger OnDrillDown()
                    begin

                    end;

                }

            }


            repeater("Distribution Details")
            {

                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    trigger OnValidate()
                    var
                        RiskFactorMr: Record "Risk Factor Master";
                    begin
                        RiskFactorMr.Reset();
                        RiskFactorMr.SetRange("Location Code", "Location Code");
                        RiskFactorMr.SetRange(Season, Season);
                        RiskFactorMr.SetRange(Variety, Variety);
                        if RiskFactorMr.IsEmpty then
                            Error('There is no risk factor master for this Location %1 , Season %2 , Variety %3!');

                        CalcFields("Risk Factor %");
                        CalcFields("Last Production Plan Qty");
                        CalcFields("Average Yield / Acre in MT");
                        CalcFields("Seed Rate / Acre");
                        "Raw Prod. req. assum 67% Risk" := "Last Production Plan Qty" / (100 - "Risk Factor %") * 100;
                        "Acreage Required" := "Raw Prod. req. assum 67% Risk" / "Average Yield / Acre in MT";
                        "PS Required for Distribution" := Round("Acreage Required" * "Seed Rate / Acre", 1, '=');
                    end;

                }
                field("Last Production Plan Qty"; "Last Production Plan Qty")
                {
                    ApplicationArea = all;
                    CaptionClass = '1,5,,' + Dynamiccolumn1;
                    Style = StrongAccent;
                }
                field("Risk Factor %"; "Risk Factor %")
                {
                    ApplicationArea = all;
                    Style = Ambiguous;

                }
                field("Raw Prod. req. assum 67% Risk"; "Raw Prod. req. assum 67% Risk")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    Image = TileYellow;



                }
                field("Average Yield / Acre in MT"; "Average Yield / Acre in MT")
                {
                    ApplicationArea = all;
                    Style = Ambiguous;

                }
                field("Seed Rate / Acre"; "Seed Rate / Acre")
                {
                    ApplicationArea = all;
                    Style = Ambiguous;

                }
                field("PS Required for Distribution"; "PS Required for Distribution")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;

                }
                field("Acreage Required"; "Acreage Required")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;

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
    trigger OnAfterGetRecord()
    begin
        SetColumnCaptions();
        CalcuateTotalPSRequired();

    end;

    trigger OnOpenPage()
    begin
        SetColumnCaptions();
        CalcuateTotalPSRequired();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetColumnCaptions();
        CalcuateTotalPSRequired();
    end;

    local procedure SetColumnCaptions()
    var
        SeasonMaster: Array[4] of Record "Season Master";
    begin
        Clear(Dynamiccolumn1);

        if Season <> '' then begin
            SeasonMaster[1].Reset();
            SeasonMaster[1].SetRange("Season Code", Season);
            SeasonMaster[1].FindFirst();
            SeasonMaster[2].Reset();
            SeasonMaster[2].SetRange(Sequence, SeasonMaster[1].Sequence + 1);
            SeasonMaster[2].FindLast();
            SeasonMaster[3].Reset();
            SeasonMaster[3].SetRange(Sequence, SeasonMaster[2].Sequence + 1);
            SeasonMaster[3].FindLast();
            SeasonMaster[4].Reset();
            SeasonMaster[4].SetRange(Sequence, SeasonMaster[1].Sequence - 1);
            SeasonMaster[4].FindLast();
            Dynamiccolumn1 := 'Total ' + SeasonMaster[4]."Season Code" + ' Production Plan';
        end;
    end;

    local procedure CalcuateTotalPSRequired()
    var
        LocationWiseDistr: Record "Location Wise Prod. Dist.";
    begin
        Clear(TotalPSRequired);
        LocationWiseDistr.Reset();
        LocationWiseDistr.SetCurrentKey("Production Plan No.", Season, Variety, "Location Code");
        LocationWiseDistr.SetRange("Production Plan No.", Rec."Production Plan No.");
        LocationWiseDistr.SetRange(Season, Rec.Season);
        LocationWiseDistr.SetRange(Variety, Rec.Variety);
        LocationWiseDistr.CalcSums("PS Required for Distribution", "Raw Prod. req. assum 67% Risk");
        TotalPSRequired := LocationWiseDistr."PS Required for Distribution";
        TotalExpectedRawTarget := LocationWiseDistr."Raw Prod. req. assum 67% Risk";

    end;

    var
        Dynamiccolumn1: Text[150];
        TotalPSRequired: Decimal;
        TotalExpectedRawTarget: Decimal;
}