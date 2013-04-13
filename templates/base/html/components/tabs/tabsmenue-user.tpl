			<div class="navbar">
				<div class="navbar-inner">	
					<ul class="nav">
						{if $userid == $user.ID}
						<li {if $projecttab == "active" }class="active"{/if}>
							<a href="manageuser.php?action=profile&amp;id={$userid}">{#myaccount#}</a>
						</li>
						{/if}
						{if $userpermissions.admin.add and $userid != $user.ID}
						<li {if $milestab == "active" }class="active"{/if}>
							<a href="admin.php?action=editform&amp;id={$user.ID}">{#edit#}</a>
						</li>
						{elseif $userid == $user.ID}
						<li {if $edittab == "active" }class="active"{/if}>
							<a href="manageuser.php?action=editform&amp;id={$user.ID}">{#edit#}</a>
						</li>
						{/if}
					</ul>	
				</div>
			</div>