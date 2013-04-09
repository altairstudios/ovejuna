<div class="well">
	<div>
		<form method="get" action="managesearch.php">
			<div class="input-append">
				<input class="span12" id="query" name="query" type="text" autocomplete="off" />
				<button class="btn" type="submit">{#gosearch#}</button>
			</div>
			<input type="hidden" name="action" value="search" />
		</form>
	</div>
	{if $openProjects[0].ID > 0}
		<div>
			<h2 class="nav-header">{#myprojects#}</h2>
			<div>
				<form>
					<select class="span12" onchange="document.location='manageproject.php?action=showproject&id='+this.value;">
						<option>{#chooseone#}</option>
						{section name=drop loop=$openProjects}
							<option value="{$openProjects[drop].ID}">{$openProjects[drop].name|truncate:40:"...":true}</option>
						{/section}
					</select>
				</form>
			</div>
		</div>
	{/if}
	<div>
		<h2 class="nav-header">{#usersonline#}</h2>
		<ul id="onlinelist" class="nav nav-list">
			{$cloud}
		</ul>
	</div>
</div>

{literal}
<script type="text/javascript">
	jQuery("#query").typeahead({
		source: function() {
			var results; 
			
			jQuery.ajax({
				async: false,
				data: {
					query: jQuery("#query").val()
				},
				success: function(data) {
					results = data;
				},
				type: "GET",
				url: "managesearch.php?action=autocomplete",
				dataType: "json"
			});
			
			return results;
		}
	});
	
	var getUsersOnline = function() {
		jQuery.get("manageuser.php?action=onlinelist", function(data) {
			jQuery("#onlinelist").html(data);
		});
	}
	
	setInterval(getUsersOnline, 30000);
	
	getUsersOnline();
</script>
{/literal}