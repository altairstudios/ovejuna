{*Projects*}
{if $projectnum > 0}
	<div class="row-fluid">
		<div class="span12">
			<div class="well well-small">
				<a href="myprojects.php" title="{#myprojects#}">{#myprojects#}</a>
				{if $userpermissions.projects.add}
				<div class="pull-right">
					<a class="btn btn-mini" href="#"><i class="icon-plus"></i></a>
				</div>
				{/if}
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			{include file="addproject.tpl" myprojects="1"}
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<table class="table table-bordered table-striped table-projects">
				<thead>
					<tr>
						<th>{#project#}</th>
						<th>{#done#}</th>
						<th>{#daysleft#}&nbsp;&nbsp;</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					{section name=project loop=$myprojects}
						<tr {if $myprojects[project].daysleft < 0 && $myprojects[project].daysleft != ""} class="error"{elseif $myprojects[project].daysleft == "0"} class="warning"{/if}>
							<td>
								<a href="manageproject.php?action=showproject&amp;id={$myprojects[project].ID}" title="{$myprojects[project].name}">
									{$myprojects[project].name|truncate:33:"...":true}
								</a>
							</td>
							<td>
								<div class="progress">
									<div class="bar" style="width: {$myprojects[project].done}%;">{$myprojects[project].done}%</div>
								</div>
							</td>
							<td>{$myprojects[project].daysleft}</td>
							<td>
								{if $userpermissions.projects.close}
									<a class="btn btn-mini" href="#" onclick="javascript:closeElement('proj_{$myprojects[project].ID}','manageproject.php?action=close&amp;id={$myprojects[project].ID}');" title="{#close#}"><i class="icon-ok"></i></a>
								{/if}
								{if $userpermissions.projects.edit}
									<a class="btn btn-mini" href="#" onclick="change('manageproject.php?action=editform&amp;id={$myprojects[project].ID}','form_addmyproject');blindtoggle('form_addmyproject');" title="{#edit#}"><i class="icon-pencil"></i></a>
								{/if}
								{if $userpermissions.projects.del}
									<a class="btn btn-mini" href="#" onclick="javascript:confirmfunction('{#confirmdel#}','deleteElement(\'proj_{$myprojects[project].ID}\',\'manageproject.php?action=del&amp;id={$myprojects[project].ID}\')');" title="{#delete#}"><i class="icon-remove"></i></a>
								{/if}
							</td>
						</tr>
					{/section}
				</tbody>
			</table>
		</div>
	</div>
	
	{if $userpermissions.projects.add}
	<div class="row-fluid">
		<div class="span12">
			<a class="btn btn-primary" href="javascript:blindtoggle('form_addmyproject');" onclick="toggleClass('add_myprojects','add-active','add');toggleClass('sm_deskprojects','smooth','nosmooth');">{#addproject#}</a>
		</div>
	</div>
	{/if}

	
	<div id="form_addmyproject" class="addmenue" style="display:none;">
		{include file="addproject.tpl" myprojects="1"}
	</div>
{/if}{*Projects End*}