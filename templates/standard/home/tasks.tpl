{*Tasks*}
		{if $tasknum > 0}
			<div class="tasks">
				<div class="headline">
					<a href="javascript:void(0);" id="taskhead_toggle" class="{$taskbar}" onclick = "toggleBlock('taskhead');"></a>

					<div class="wintools">
						<div class="export-main">
							<a class="export"><span>{#export#}</span></a>
							<div class="export-in"  style="width:69px;left: -69px;"> {*at two items*}

								<a class="rss" href="managerss.php?action=rss-tasks&user={$userid}"><span>{#rssfeed#}</span></a>
								<a class="ical" href="managetask.php?action=ical"><span>{#icalexport#}</span></a>
								<a class="pdf" href="mytasks.php?action=pdf"><span>{#pdfexport#}</span></a>
							</div>
						</div>
					</div>

					<h2>
						<a href="mytasks.php" title="{#mytasks#}"><img src="./templates/standard/images/symbols/tasklist.png" alt="" />{#mytasks#}</a>
					</h2>
				</div>

				<div class="block" id="taskhead" style = "{$taskstyle}">
					<div id = "form_addmytask" class="addmenue" style = "display:none;">
						{include file="addmytask_index.tpl" }
					</div>

				<div class="nosmooth" id="sm_desktoptasks">
					<table id = "desktoptasks" cellpadding="0" cellspacing="0" border="0">
						<thead>
							<tr>
								<th class="a"></th>
								<th class="b" style="cursor:pointer;" onclick = "sortBlock('desktoptasks','');">{#task#}</th>
								<th class="c" style="cursor:pointer;" onclick = "sortBlock('desktoptasks','project');">{#project#}</th>
								<th class="d" style="cursor:pointer;text-align:right" onclick = "sortBlock('desktoptasks','daysleft');">{#daysleft#}&nbsp;&nbsp;</th>
								<th class="tools"></th>
							</tr>
						</thead>

						<tfoot>
							<tr>
								<td colspan="5"></td>
							</tr>
						</tfoot>

						{section name = task loop=$tasks}
							{*Color-Mix*}
							{if $smarty.section.task.index % 2 == 0}
							<tbody class="color-a" id="task_{$tasks[task].ID}" rel = "{$tasks[task].ID},{$tasks[task].title},{$tasks[task].daysleft},{$tasks[task].pname}">
							{else}
							<tbody class="color-b" id="task_{$tasks[task].ID}" rel = "{$tasks[task].ID},{$tasks[task].title},{$tasks[task].daysleft},{$tasks[task].pname}">
							{/if}
								<tr {if $tasks[task].daysleft < 0} class="marker-late"{elseif $tasks[task].daysleft == 0} class="marker-today"{/if}>
									<td>
										{if $userpermissions.tasks.close}
											<a class="butn_check" href="javascript:closeElement('task_{$tasks[task].ID}','managetask.php?action=close&amp;tid={$tasks[task].ID}&amp;id={$tasks[task].project}');" title="{#close#}"></a>
										{/if}
									</td>
									<td>
										<div class="toggle-in">
											<span id = "desktoptaskstoggle{$tasks[task].ID}" class="acc-toggle" onclick="javascript:accord_tasks.activate($$('#taskhead .accordion_toggle')[{$smarty.section.task.index}]);toggleAccordeon('taskhead',this);"></span>
											<a href="managetask.php?action=showtask&amp;id={$tasks[task].project}&amp;tid={$tasks[task].ID}" title="{$tasks[task].title}">
											{if $tasks[task].title != ""}
												{$tasks[task].title|truncate:33:"...":true}
											{else}
												{$tasks[task].text|truncate:33:"...":true}
											{/if}
											</a>
										</div>
									</td>
									<td>
										<a href = "managetask.php?action=showproject&amp;id={$tasks[task].project}">{$tasks[task].pname|truncate:30:"...":true}</a>
									</td>
									<td style="text-align:right">{$tasks[task].daysleft}&nbsp;&nbsp;</td>
									<td class="tools">
										{if $userpermissions.tasks.edit}
											<a class="tool_edit" href="javascript:void(0);"  onclick = "change('managetask.php?action=editform&amp;tid={$tasks[task].ID}&amp;id={$tasks[task].project}','form_addmytask');toggleClass(this,'tool_edit_active','tool_edit');blindtoggle('form_addmytask');" title="{#edit#}"></a>

										{/if}
										{if $userpermissions.tasks.del}
											<a class="tool_del" href="javascript:confirmfunction('{#confirmdel#}','deleteElement(\'task_{$tasks[task].ID}\',\'managetask.php?action=del&amp;tid={$tasks[task].ID}&amp;id={$tasks[task].project}\')');"  title="{#delete#}"></a>
										{/if}
									</td>
								</tr>

								<tr class="acc">
									<td colspan="5">
										<div class="accordion_toggle"></div>
										<div class="accordion_content">
											<div class="acc-in">
												<div class="message-in">
													{$tasks[task].text|nl2br}
												</div>
											</div>
										</div>
									</td>
								</tr>
							</tbody>
						{/section}
					</table>

					<div class="tablemenue">
						<div class="tablemenue-in">
							{if $userpermissions.tasks.add}
								<a class="butn_link" href="javascript:void(0);" id="add_butn_mytasks" onclick="blindtoggle('form_addmytask');toggleClass(this,'butn_link_active','butn_link');toggleClass('sm_desktoptasks','smooth','nosmooth');">{#addtask#}</a>
							{/if}
						</div>
					</div>
				</div> {*block END*}
			  </div> {* Smooth end *}
			</div> {*tasks END*}
			<div class="content-spacer"></div>
		{/if}{*Tasks End*}