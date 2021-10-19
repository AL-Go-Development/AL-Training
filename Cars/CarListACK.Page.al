page 50000 "Car List ACK"
{
    Extensible = false;
    ApplicationArea = All;
    Caption = 'Cars';
    PageType = List;
    SourceTable = "Car ACK";
    UsageCategory = Lists;
    CardPageId = "Car Card ACK";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(VIN; Rec.VIN)
                {
                    ToolTip = 'Specifies the value of the VIN field.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field("Make Code"; Rec."Make Code")
                {
                    ToolTip = 'Specifies the value of the Make Code field.';
                    ApplicationArea = All;
                }
                field("Model Code"; Rec."Model Code")
                {
                    ToolTip = 'Specifies the value of the Model Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.GetDescription())
                {
                    Caption = 'Description';
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
                    ToolTip = 'Specifies the value of the Model field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}