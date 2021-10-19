page 50006 "Make Card ACK"
{
    Extensible = false;
    Caption = 'Make Card';
    PageType = Card;
    SourceTable = "Make ACK";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
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
                group(Logo)
                {
                    Caption = 'Logo';
                    field(Picture; Rec.Picture)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the make''s logo.';

                        trigger OnValidate()
                        begin
                            CurrPage.SaveRecord();
                        end;
                    }
                }
            }
            part(ModelSubform; "Model Subform ACK")
            {
                Caption = 'Models';
                SubPageLink = "Make Code" = field("Code");
                ApplicationArea = All;
            }
        }
    }
}