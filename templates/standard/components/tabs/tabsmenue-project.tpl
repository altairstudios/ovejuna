			<div class="navbar">
				<div class="navbar-inner navbar-mini">
					<ul class="nav">
						<li {if $projecttab == "active" }class="active"{/if}>
							<a href="manageproject.php?action=showproject&amp;id={$project.ID}">{#project#}</a>
						</li>
						{if $userpermissions.milestones.view}
						<li {if $milestab == "active" }class="active"{/if}>
							<a href="managemilestone.php?action=showproject&amp;id={$project.ID}">{#milestones#}</a>
						</li>
						{/if}
						{if $userpermissions.tasks.view}
						<li {if $taskstab == "active" }class="active"{/if}>
							<a href="managetask.php?action=showproject&amp;id={$project.ID}">{#tasklists#}</a>
						</li>
						{/if}
						{if $userpermissions.messages.view}
						<li {if $msgstab == "active" }class="active"{/if}>
							<a href="managemessage.php?action=showproject&amp;id={$project.ID}">{#messages#}</a>
						</li>
						{/if}
						{if $userpermissions.files.view}
						<li {if $filestab == "active" }class="active"{/if}>
							<a href="managefile.php?action=showproject&amp;id={$project.ID}">{#files#}</a>
						</li>
						{/if}
						<li {if $userstab == "active" }class="active"{/if}>
							<a href="manageuser.php?action=showproject&amp;id={$project.ID}">{#user#}</a>
						</li>
						{if $userpermissions.timetracker.view}
						<li {if $timetab == "active" }class="active"{/if}>
							<a href="managetimetracker.php?action=showproject&amp;id={$project.ID}">{#timetracker#}</a>
						</li>
						{/if}
					</ul>
				</div>
			</div>