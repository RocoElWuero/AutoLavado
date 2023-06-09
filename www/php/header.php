<header class="header">
	<?php
		if (!empty($_SESSION['correo'])) {
			?>
				<a href="#">
					<?php
						echo $_SESSION['correo'];
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
