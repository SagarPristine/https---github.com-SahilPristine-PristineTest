page 50143 "Test Fixed Layout"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Germination Evaluation";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {

            group(General)
            {
                field("Crop Code"; rec."Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = all;
                }
                field("Item Product Group Code"; rec."Item Product Group Code")
                {
                    ApplicationArea = all;
                }
                field("Item Class of Seeds"; rec."Item Class of Seeds")
                {
                    ApplicationArea = all;
                }

                field("Qty (Kg)"; rec."Qty (Kg)")
                {
                    ApplicationArea = all;
                }
                field("Bute No."; rec."Bute No.")
                {
                    ApplicationArea = all;
                }
                field(Stage; rec.Stage)
                {
                    ApplicationArea = all;
                }
                field("Received Date Time"; rec."Received Date Time")
                {
                    ApplicationArea = all;
                }
                field("Date of Putting"; rec."Date of Putting")
                {
                    ApplicationArea = all;
                }
                field("Date of Test"; rec."Date of Test")
                {
                    ApplicationArea = all;
                }
                field("Sample Code"; rec."Sample Code")
                {
                    ApplicationArea = all;
                }
                field("Subjected to Count II"; rec."Subjected to Count II")
                {
                    ApplicationArea = all;

                }
            }
            group(CountI)
            {
                Caption = 'Count I';
                grid("Count I")
                {

                    group("Total Count I")

                    {

                        field("Count I R-I T"; Rec."Count I R-I T")
                        {
                            ApplicationArea = All;
                            Style = Favorable;
                            Caption = 'Count R-I';

                        }
                        field("Count I R-II T"; Rec."Count I R-II T")
                        {
                            ApplicationArea = All;
                            Caption = 'Count R-II';
                            Style = Favorable;

                        }
                        field("Count I R-III T"; Rec."Count I R-III T")
                        {
                            ApplicationArea = All;
                            Caption = 'Count R-III';
                            Style = Favorable;

                        }
                        field("Count I R-IV T"; Rec."Count I R-IV T")
                        {
                            ApplicationArea = All;
                            Caption = 'Count R-IV';
                            Style = Favorable;

                        }
                    }

                    group("Normal Seed Lings")
                    {
                        field("Count I R-I NSL"; Rec."Count I R-I NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-II NSL"; Rec."Count I R-II NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-III NSL"; Rec."Count I R-III NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;

                        }
                        field("Count I R-IV NSL"; Rec."Count I R-IV NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;

                        }
                    }
                    group("Abnormal Seed Lings")
                    {

                        field("Count I R-I ASL"; Rec."Count I R-I ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-II ASL"; Rec."Count I R-II ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-III ASL"; Rec."Count I R-III ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-IV ASL"; Rec."Count I R-IV ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }
                    group("Fresh Un-Germinated")
                    {

                        field("Count I R-I FUG"; Rec."Count I R-I FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-II FUG"; Rec."Count I R-II FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-III FUG"; Rec."Count I R-III FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-IV FUG"; Rec."Count I R-IV FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }
                    group("Hard Seed")
                    {

                        field("Count I R-I HS"; Rec."Count I R-I HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-II HS"; Rec."Count I R-II HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-III HS"; Rec."Count I R-III HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-IV HS"; Rec."Count I R-IV HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }
                    group("Dead Seed")
                    {
                        field("Count I R-I DS"; Rec."Count I R-I DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-II DS"; Rec."Count I R-II DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-III DS"; Rec."Count I R-III DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count I R-IV DS"; Rec."Count I R-IV DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }

                }
            }
            field("Count I %"; Rec."Count I %")
            {

                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Count I % field.';
            }
            field("Count I Result"; Rec."Count I Result")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Count I Result field.';
            }
            field("Count I Result Date"; Rec."Count I Result Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Count I Result Date field.';
            }
            group(CountII)
            {
                Caption = 'Count II';
                grid("Count II")
                {
                    group("Total Count II")
                    {

                        field("Count II R-I T"; Rec."Count II R-I T")
                        {
                            ApplicationArea = All;
                            Style = Favorable;
                            Caption = 'Count II R-I';

                        }
                        field("Count II R-II T"; Rec."Count II R-II T")
                        {
                            ApplicationArea = All;
                            Caption = 'Count II R-II';
                            Style = Favorable;

                        }
                        field("Count II R-III T"; Rec."Count II R-III T")
                        {
                            ApplicationArea = All;
                            Caption = 'Count II R-III';
                            Style = Favorable;

                        }
                        field("Count II R-IV T"; Rec."Count II R-IV T")
                        {
                            ApplicationArea = All;
                            Caption = 'Count II R-IV';
                            Style = Favorable;

                        }
                    }

                    group("Normal Seed Lings II")
                    {
                        field("Count II R-I NSL"; Rec."Count II R-I NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-II NSL"; Rec."Count II R-II NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-III NSL"; Rec."Count II R-III NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;

                        }
                        field("Count II R-IV NSL"; Rec."Count II R-IV NSL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV NSL field.';
                            ShowCaption = false;
                            Style = StrongAccent;

                        }
                    }
                    group("Abnormal Seed Lings II")
                    {

                        field("Count II R-I ASL"; Rec."Count II R-I ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-II ASL"; Rec."Count II R-II ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-III ASL"; Rec."Count II R-III ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-IV ASL"; Rec."Count II R-IV ASL")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV ASL field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }
                    group("Fresh Un-Germinated II")
                    {

                        field("Count II R-I FUG"; Rec."Count II R-I FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-II FUG"; Rec."Count II R-II FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-III FUG"; Rec."Count II R-III FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-IV FUG"; Rec."Count II R-IV FUG")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV FUG field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }
                    group("Hard Seed II")
                    {

                        field("Count II R-I HS"; Rec."Count II R-I HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-II HS"; Rec."Count II R-II HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-III HS"; Rec."Count II R-III HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-IV HS"; Rec."Count II R-IV HS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV HS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }
                    group("Dead Seed II")
                    {
                        field("Count II R-I DS"; Rec."Count II R-I DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-I DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-II DS"; Rec."Count II R-II DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-II DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-III DS"; Rec."Count II R-III DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-III DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                        field("Count II R-IV DS"; Rec."Count II R-IV DS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Count I R-IV DS field.';
                            ShowCaption = false;
                            Style = StrongAccent;
                        }
                    }

                }

            }
            field("Count II %"; Rec."Count II %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Count II % field.';
            }
            field("Count II Result"; Rec."Count II Result")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Count II Result field.';
            }
            field("Count II Result Date"; Rec."Count II Result Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Count II Result Date field.';
            }
        }
    }
    var
}

