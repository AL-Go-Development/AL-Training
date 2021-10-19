report 50000 "Car ACK"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Car.rdlc';
    Caption = 'Car';
    UsageCategory = None;

    dataset
    {
        dataitem(Car; "Car ACK")
        {
            RequestFilterFields = "No.", "Customer No.";
            DataItemTableView = sorting("No.");

            column(Picture_CompanyInformation; CompanyInformation.Picture)
            {
            }
            column(Address1_CompanyInformation; CompanyInformationAddress[1])
            {
            }
            column(Address2_CompanyInformation; CompanyInformationAddress[2])
            {
            }
            column(Address3_CompanyInformation; CompanyInformationAddress[3])
            {
            }
            column(Address4_CompanyInformation; CompanyInformationAddress[4])
            {
            }
            column(Address5_CompanyInformation; CompanyInformationAddress[5])
            {
            }
            column(Address6_CompanyInformation; CompanyInformationAddress[6])
            {
            }
            column(Address7_CompanyInformation; CompanyInformationAddress[7])
            {
            }
            column(Address8_CompanyInformation; CompanyInformationAddress[8])
            {
            }
            column(No_Car; "No.")
            {
            }
            column(Description_Car; Car.GetDescription())
            {
            }
            column(CustomerNo_Car; "Customer No.")
            {
            }
            column(BodyType_Car; "Body Type")
            {
            }
            column(EngineType_Car; "Engine Type")
            {
            }
            column(MakeCode_Car; "Make Code")
            {
            }
            column(MakeDescription_Car; "Make Description")
            {
            }
            column(ModelCode_Car; "Model Code")
            {
            }
            column(ModelDescription_Car; "Model Description")
            {
            }
            column(SystemCreatedBy_Car; CreatedUserName)
            {
            }
            column(SystemModifiedBy_Car; SystemModifiedBy)
            {
            }
            column(VIN_Car; VIN)
            {
            }
            column(Weight_Car; Weight)
            {
            }
            column(Year_Car; Year)
            {
            }
            column(SystemCreatedAt_Car; SystemCreatedAt)
            {
            }
            column(SystemModifiedAt_Car; SystemModifiedAt)
            {
            }
            column(HasImages; HasImages)
            {
            }
            column(HasDocuments; HasDocuments)
            {
            }
            column(IncludeAttachmentsCol; IncludeAttachments)
            {
            }
            dataitem(Attachment; "Attachment ACK")
            {
                DataItemLink = "Car No." = field("No.");
                DataItemTableView = sorting(Position);
                column(No_Attachment; "No.")
                {
                }
                column(Description_Attachment; Description)
                {
                }
                column(Type_Attachment; "Type")
                {
                }
                column(Filename_Attachment; Filename)
                {
                }
                column(FileExtension_Attachment; "File Extension")
                {
                }
                column(ImageData_Attachment; "Image Data")
                {
                }
                column(CreatedBy_Attachment; "Created By")
                {
                }
                column(CreatedAt_Attachment; SystemCreatedAt)
                {
                }
            }
            trigger OnAfterGetRecord() //Header
            var
                Attachment: Record "Attachment ACK";
                User: Record User;
            begin
                Attachment.SetRange("Car No.", Car."No.");
                Attachment.SetRange("Type", Attachment."Type"::Image);
                if Attachment.IsEmpty() then
                    HasImages := 0
                else
                    HasImages := 1;

                Attachment.SetRange("Car No.", Car."No.");
                Attachment.SetRange("Type", Attachment."Type"::Document);
                if Attachment.IsEmpty() then
                    HasDocuments := 0
                else
                    HasDocuments := 1;

                if User.Get(Car.SystemCreatedBy) then
                    CreatedUserName := User."User Name";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(IncludeAttachmentsQst; IncludeAttachments)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Attachments';
                        ToolTip = 'Specifies if attachments should be printed.';
                    }
                }
            }
        }
    }
    labels
    {
        ReportCaption = 'Car';
        MakeCodeCaption = 'Make Code';
        ModelCodeCaption = 'Model Code';
        YearCaption = 'Year';
        MakeDescriptionCaption = 'Make Description';
        ModelDescriptionCaption = 'Model Description';
        VINCaption = 'VIN';
        BodyCaption = 'Body';
        EngineCaption = 'Engine';
        WeightCaption = 'Weight';
        NoCaption = 'No.';
        CustomerNoCaption = 'Customer No.';
        DescriptionCaption = 'Description';
        TypeCaption = 'Type';
        ImagesCaption = 'Images';
        DocumentsCaption = 'Documents';
        FilenameCaption = 'Filename';
        FileExtensionCaption = 'Extension';
        ContentTypeCaption = 'Content Type';
        CreatedByCaption = 'Created By';
        CreatedOnCaption = 'Created On';
    }

    trigger OnInitReport()
    var
        FormatAddress: Codeunit "Format Address";
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
        FormatAddress.Company(CompanyInformationAddress, CompanyInformation);

        if CompanyInformationCountry.Get(CompanyInformation."Country/Region Code") then;

        IncludeAttachments := true;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyInformationCountry: Record "Country/Region";
        IncludeAttachments: Boolean;
        HasDocuments: Integer;
        HasImages: Integer;
        CreatedUserName: Text;
        CompanyInformationAddress: array[8] of Text[100];
}
