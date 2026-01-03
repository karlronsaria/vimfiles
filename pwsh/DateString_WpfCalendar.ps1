Add-Type -AssemblyName PresentationFramework

[Xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window"
    Title="MainWindow"
    Height="228"
    Width="417"
    SizeToContent="WidthAndHeight"
    Background="#FF1F1F1F"
    >
    <Window.Resources>
        <Style x:Key="Control" TargetType="{x:Type Control}">
            <Setter Property="Background" Value="#FF383838"/>
            <Setter Property="Foreground" Value="#FFFAFAFA"/>
            <Setter Property="BorderBrush" Value="#FF424242"/>
            <Setter Property="FocusVisualStyle">
                <Setter.Value>
                    <Style>
                        <Setter Property="Control.Template">
                            <Setter.Value>
                                <ControlTemplate>
                                    <Rectangle
                                        StrokeThickness="1"
                                        Stroke="DeepSkyBlue"
                                        StrokeDashArray="2"
                                        />
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                    </Style>
                </Setter.Value>
            </Setter>
        </Style>
        <Style
            x:Key="MyButton"
            TargetType="Button"
            BasedOn="{StaticResource Control}"
            />
        <Style
            x:Key="MyTextBox"
            TargetType="TextBox"
            BasedOn="{StaticResource Control}"
            />
    </Window.Resources>
    <Grid
        FocusManager.FocusedElement="{Binding ElementName=Calendar}"
        HorizontalAlignment="Stretch"
        Height="Auto"
        VerticalAlignment="Stretch"
        Width="Auto"
        OpacityMask="Black">
        <Calendar
            Name="Calendar"
            HorizontalAlignment="Left"
            Margin="10,10,0,0"
            VerticalAlignment="Top"
            KeyboardNavigation.TabIndex="0"
            />
        <TextBox
            Name="Message"
            Margin="10,183,10,10"
            TextWrapping="Wrap"
            Text=""
            VerticalAlignment="Top"
            MinHeight="10"
            IsReadOnly="True"
            VerticalContentAlignment="Center"
            Style="{StaticResource MyTextBox}"
            Background="Transparent"
            BorderThickness="0"
            Focusable="False"
            />
        <Button
            Name="PrintButton"
            IsDefault="True"
            Content="Print &amp; _Go"
            VerticalAlignment="Top"
            Margin="200,12,10,0"
            MinWidth="120"
            VerticalContentAlignment="Center"
            Style="{StaticResource MyButton}"
            KeyboardNavigation.TabIndex="1"
            />
        <Button
            Name="CopyStandardButton"
            Content="_Copy To Clipboard"
            VerticalAlignment="Top"
            Margin="200,36,10,0"
            MinWidth="120"
            VerticalContentAlignment="Center"
            Style="{StaticResource MyButton}"
            KeyboardNavigation.TabIndex="2"
            />
        <Button
            Name="CopyWeekButton"
            Content="Copy _Week Date"
            VerticalAlignment="Top"
            Margin="200,60,10,0"
            MinWidth="120"
            VerticalContentAlignment="Center"
            Style="{StaticResource MyButton}"
            KeyboardNavigation.TabIndex="3"
            />
        <Button
            Name="CopyPrettyButton"
            Content="Copy _Pretty Date"
            VerticalAlignment="Top"
            Margin="200,84,10,0"
            MinWidth="120"
            VerticalContentAlignment="Center"
            Style="{StaticResource MyButton}"
            KeyboardNavigation.TabIndex="4"
            />
        <Button
            Name="CancelButton"
            IsCancel="True"
            Content="Ca_ncel"
            VerticalAlignment="Top"
            Margin="200,108,10,0"
            MinWidth="120"
            VerticalContentAlignment="Center"
            Style="{StaticResource MyButton}"
            KeyboardNavigation.TabIndex="5"
            />
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$calendar = $window.FindName("Calendar")
$message = $window.FindName("Message")
$print = $window.FindName("PrintButton")
$copy = $window.FindName("CopyStandardButton")
$week = $window.FindName("CopyWeekButton")
$pretty = $window.FindName("CopyPrettyButton")
$cancel = $window.FindName("CancelButton")

$stdFormat = 'yyyy-MM-dd' # Uses DateTimeFormat
$weekFormat = "ddd $stdFormat"
$prettyFormat = 'd MMMM yyyy'

$global:__WINDOW_RESULT__ = [PsCustomObject]@{
    Success = $false
    Print = $false
    Date = ''
}

function Get-SelectedDate {
    Param(
        [System.Windows.Controls.Calendar]
        $Calendar
    )

    $now = $Calendar.DisplayDate
    $date = $Calendar.SelectedDate

    if (-not $date) {
        $date = $now
    }

    return $date
}

function Get-SelectedDateString {
    Param(
        [System.Windows.Controls.Calendar]
        $Calendar,

        [String]
        $Format
    )

    $date = Get-SelectedDate $calendar
    return Get-Date $date -Format $Format
}

function Save-ToClipboard {
    Param(
        $InputObject
    )

    Set-Clipboard $InputObject
    $Message.Text = "Copied '$InputObject' to Clipboard"
}

$copy.Add_Click({
    $dateStr = Get-SelectedDateString `
        -Calendar $calendar `
        -Format $stdFormat

    Save-ToClipboard $dateStr

    $global:__WINDOW_RESULT__ = [PsCustomObject]@{
        Success = $true
        Print = $false
        Date = $dateStr
    }
})

$week.Add_Click({
    $dateStr = Get-SelectedDateString `
        -Calendar $calendar `
        -Format $weekFormat

    Save-ToClipboard $dateStr

    $global:__WINDOW_RESULT__ = [PsCustomObject]@{
        Success = $true
        Print = $false
        Date = $dateStr
    }
})

$pretty.Add_Click({
    $dateStr = Get-SelectedDateString `
        -Calendar $calendar `
        -Format $prettyFormat

    Save-ToClipboard $dateStr

    $global:__WINDOW_RESULT__ = [PsCustomObject]@{
        Success = $true
        Print = $false
        Date = $dateStr
    }
})

$print.Add_Click({
    $dateStr = Get-SelectedDateString `
        -Calendar $calendar `
        -Format $stdFormat

    $global:__WINDOW_RESULT__ = [PsCustomObject]@{
        Success = $true
        Print = $true
        Date = $dateStr
    }

    $window.Close()
})

$cancel.Add_Click({
    $global:__WINDOW_RESULT__ = [PsCustomObject]@{
        Success = $false
        Print = $false
        Date = ""
    }

    $window.Close()
})

$window.Add_PreViewKeyDown({
    if ($_.Key -eq 'Enter') {
        $global:__WINDOW_RESULT__ = if ($cancel.IsFocused) {
            [PsCustomObject]@{
                Success = $false
                Print = $false
                Date = ''
            }
        } else {
            $dateStr = Get-SelectedDateString `
                -Calendar $calendar `
                -Format $stdFormat

            [PsCustomObject]@{
                Success = $true
                Print = $true
                Date = $dateStr
            }
        }

        $window.Close()
    }
})

$window.Add_ContentRendered({
    $this.Activate()
})

[void]$window.ShowDialog()
$script:result = $global:__WINDOW_RESULT__

Remove-Variable `
    -Name __WINDOW_RESULT__ `
    -Scope Global

return $script:result

