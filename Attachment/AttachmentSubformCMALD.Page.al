page 50008 "Attachment Subform ACK"
{
    Extensible = false;
    Caption = 'Attachment Subform';
    PageType = ListPart;
    SourceTable = "Attachment ACK";
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(Filename; Rec.Filename)
                {
                    ToolTip = 'Specifies the value of the Filename field.';
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ToolTip = 'Specifies the value of the "File Extension" field.';
                    ApplicationArea = All;
                }
                field("Content Type"; Rec."Content Type")
                {
                    ToolTip = 'Specifies the value of the Content Type field.';
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    Rec.ImportFromCamera(gCarNo);
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                begin
                    Rec.ImportFromDevice(gCarNo);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        Camera: Codeunit Camera;
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    internal procedure SetFilters(CarNo: Code[20])
    begin
        gCarNo := CarNo;
    end;

    var
        CameraAvailable: Boolean;
        gCarNo: Code[20];
}