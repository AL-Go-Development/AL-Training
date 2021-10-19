page 50003 "Make List ACK"
{
    Extensible = false;
    ApplicationArea = All;
    Caption = 'Makes';
    PageType = List;
    SourceTable = "Make ACK";
    UsageCategory = Lists;
    CardPageId = "Make Card ACK";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}