page 50005 "Model Subform ACK"
{
    Extensible = false;
    Caption = 'Model Subform';
    PageType = ListPart;
    SourceTable = "Model ACK";

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
                field("Body Type"; Rec."Body Type")
                {
                    ToolTip = 'Specifies the value of the Body field.';
                    ApplicationArea = All;
                }
                field("Engine Type"; Rec."Engine Type")
                {
                    ToolTip = 'Specifies the value of the Engine field.';
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}