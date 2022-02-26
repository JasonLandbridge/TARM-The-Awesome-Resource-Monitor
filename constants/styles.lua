--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____general = require("constants.general")
local General = ____general.default
____exports.default = __TS__Class()
local Styles = ____exports.default
Styles.name = "Styles"
function Styles.prototype.____constructor(self)
end
Styles.RowsPaneStyle = General.Prefix .. "_rows_pane"
Styles.RowButtonStyle = General.Prefix .. "_row_button"
Styles.RowButtonSelectedStyle = General.Prefix .. "_row_button_selected"
Styles.CellBaseStyle = General.Prefix .. "_cell_base"
Styles.CellNameStyle = General.Prefix .. "_cell_name"
Styles.CellNumericValueStyle = General.Prefix .. "_cell_numeric_value"
Styles.CellResourceStyle = General.Prefix .. "_cell_resource"
____exports.default = Styles
return ____exports
