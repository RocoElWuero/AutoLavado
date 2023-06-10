<header class="header">
	<?php
		if (! empty($_SESSION["idEmpleado"]) && ! empty($_SESSION["correo"])) {
			?>
				<a href="#" style="margin: 5px;">
					<?php
						echo $_SESSION["correo"];
					?>
				</a>
				<form action="php/logout.php">
					<input type="submit" value="Logout">
				</form>
			<?php
		} else {
			?>
				<form action="php/signup.php">
					<input type="submit" value="Sign Up">
				</form>
			<?php
		}
	?>
</header>
