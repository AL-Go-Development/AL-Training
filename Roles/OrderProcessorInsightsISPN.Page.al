page 50099 "Order Processor Insights ACK"
{
    Extensible = false;
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cue ACK";
    SourceTableTemporary = true;
    Caption = 'Cars';

    layout
    {
        area(Content)
        {
            cuegroup("ACKext - Cars")
            {
                Caption = 'ACKext - Cars';
                field("Cars Last 7 Days"; Rec."Cars Last 7 Days")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Car List ACK";
                    ToolTip = 'Number of new cars this week.';
                }
                field("Cars Last 31 Days"; Rec."Cars Last 31 Days")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Car List ACK";
                    ToolTip = 'Number of new cars this month.';
                }
                field("Cars Last 12 Months"; Rec."Cars Last 12 Months")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Car List ACK";
                    ToolTip = 'Number of new cars this year.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.DeleteAll();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert(true);
        end;
    end;
}