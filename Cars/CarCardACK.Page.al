page 50001 "Car Card ACK"
{
    Extensible = false;
    Caption = 'Car';
    PageType = Card;
    SourceTable = "Car ACK";
    DataCaptionExpression = DataCaptionExpression();
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                group(CustomerID)
                {
                    Caption = 'Identification';
                    field("Customer No."; Rec."Customer No.")
                    {
                        ToolTip = 'Specifies the value of the Customer No. field.';
                        ApplicationArea = All;
                    }
                    field(VIN; Rec.VIN)
                    {
                        ToolTip = 'Specifies the value of the VIN field.';
                        ApplicationArea = All;
                    }
                }
                group(Make)
                {
                    Caption = 'Make & Model';
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
                }
                group(Properties)
                {
                    Caption = 'Properties';
                    field(Year; Rec.Year)
                    {
                        ToolTip = 'Specifies the value of the Year field.';
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
            group(Description)
            {
                Caption = 'Description';
                usercontrol(DescriptionAddin; "Text Editor Addin ACK")
                {
                    ApplicationArea = All;
                    trigger AddinLoaded()
                    begin
                        DescriptionAddinLoaded := true;
                        InitialDescription := Rec.GetDescription();
                        ModifiedDescription := InitialDescription;
                        CurrPage.DescriptionAddin.LoadContents(InitialDescription);
                    end;

                    trigger ContentChanged(Contents: Text)
                    begin
                        ModifiedDescription := Contents;
                        if InitialDescription <> ModifiedDescription then
                            Rec.SetDescription(ModifiedDescription);
                    end;
                }
            }
            part(AttachmentSubform; "Attachment Subform ACK")
            {
                Caption = 'Attachments';
                SubPageLink = "Car No." = field("No.");
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            part(DragDrop; "Attachment Drop Factbox ACK")
            {
                ApplicationArea = All;
            }
            part(ImagePreview; "Image Preview Factbox ACK")
            {
                ApplicationArea = All;
                Provider = AttachmentSubform;
                SubPageLink = "No." = field("No."), Type = const(Image);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Take Picture")
            {
                ApplicationArea = All;
                ToolTip = 'Take a picture using your mobile device camera.';
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Camera;
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    Rec.TakePicture();
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                PromotedCategory = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Print this car.';

                trigger OnAction()
                begin
                    Rec.SetRecFilter();
                    Report.Run(Report::"Car ACK", true, false, Rec);
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

    trigger OnAfterGetRecord()
    begin
        if DescriptionAddinLoaded then begin
            InitialDescription := Rec.GetDescription();
            ModifiedDescription := InitialDescription;
            CurrPage.DescriptionAddin.LoadContents(InitialDescription);
        end;

        CurrPage.DragDrop.Page.SetFilters(Rec."No.", true);
        CurrPage.AttachmentSubform.Page.SetFilters(Rec."No.");
    end;

    local procedure DataCaptionExpression(): Text
    var
        CaptionLbl: Label 'Car %1', Comment = '%1=The no.';
    begin
        exit(StrSubstNo(CaptionLbl, Rec."No."));
    end;

    var
        CameraAvailable: Boolean;
        DescriptionAddinLoaded: Boolean;
        InitialDescription: Text;
        ModifiedDescription: Text;
}