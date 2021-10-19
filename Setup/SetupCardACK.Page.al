page 50002 "Setup Card ACK"
{
    Extensible = false;
    Caption = 'Car Setup';
    PageType = Card;
    SourceTable = "Setup ACK";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("No. Series")
            {
                field("Car Nos."; Rec."Car Nos.")
                {
                    ToolTip = 'Specifies the value of the Car Nos. field.';
                    ApplicationArea = All;
                }
                field("Attachment Nos."; Rec."Attachment Nos.")
                {
                    ToolTip = 'Specifies the value of the Attachment Nos. field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty() then begin
            Rec.Init();
            Rec.Insert(true);
        end;
    end;
}