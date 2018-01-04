	Param(
        
        [String] $solution_dir ="c:\source\Accounting" , 
        [String] $project_dir ="c:\source\Accounting\Accounting",
        [String] $output_path = "c:\buildOutput"
        )
       
    $webconfig = $project_dir+"\web.config"

    Write-Output $solution_dir

    Add-Type -LiteralPath "$solution_dir\packages\MSBuild.Microsoft.VisualStudio.Web_WebApplication.Targets.12.0.2\tools\VSToolsPath\Web\Microsoft.Web.XmlTransform.dll"

    New-Item -ItemType directory -Path "$output_path\TransformedConfigs" -Force

	ls $project_dir -Filter "Web.*.config" -Exclude "web.config" ,"web.release.config", "web.debug.config" -Recurse |% {


         $xmldoc = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument;
    	 $xmldoc.PreserveWhitespace = $true
    	 $xmldoc.Load($webconfig);

         Write-Output "Transforming configuration file: " + $_.Fullname

    	 $transform = New-Object Microsoft.Web.XmlTransform.XmlTransformation($_.Fullname);

    	 $xmldoc.Save("$output_path\TransformedConfigs\"+$_.Name)
    }