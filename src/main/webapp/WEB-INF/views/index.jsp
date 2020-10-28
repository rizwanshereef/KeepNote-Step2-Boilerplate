<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Keep-Note</title>
</head>

<body>
	<!-- Create a form which will have text boxes for Note title, content and status along with a Add 
		 button. Handle errors like empty fields.  (Use dropdown-list for NoteStatus) -->
	<h1>Add a note.</h1>
	<label id="errMsg" style="color: red;"></label>

	<form method="POST" action="add" modelAttribute="noteForm">

		<div class="form-group">
			<label for="newsid">Note title</label> 
			<input type="text" class="form-control" id="noteTitle" aria-describedby="name" placeholder="Enter Note title" name="noteTitle">
		</div>

		<div class="form-group">
			<label for="exampleInputTitle">Note status</label> 
			<input type="text" class="form-control" id="noteStatus" aria-describedby="name" placeholder="Enter Note status" name="noteStatus">
		</div>

		<div class="form-group">
			<label for="exampleInputPolicyDesc">Note content</label> 
			<input type="text" class="form-control" id="noteContent" placeholder="Enter Note content" name="noteContent">
		</div>

		<button type="submit" class="btn btn-primary" onclick="return validation();" name="noteButton" id="noteButton">Submit</button>
	</form>



	<hr>
	<h1>Notes Table</h1>

	<!-- display all existing notes in a tabular structure with Title,Content,Status, Created Date and Action -->
	<form action="delete" method="get" name="deleteForm" id="deleteForm">
		<table style="border: 2px solid;">
			<tr>
				<th><c:out value="Note Id" /></th>
				<th><c:out value="Note Title" /></th>
				<th><c:out value="Note Status" /></th>
				<th><c:out value="Note Content" /></th>
				<th><c:out value="Note Created At" /></th>
				<th><c:out value="Delete" /></th>
				<th><c:out value="Update" /></th>
			</tr>
			<c:forEach items="${notes}" var="note">
				<tr class="">
					<td><input type="text" id="noteId" name="noteId"
						value="${note.noteId}"></td>
					<td><input type="text" id="noteTitle" name="noteTitle"
						value="${note.noteTitle}"></td>
					<td><input type="text" id="noteStatus" name="noteStatus"
						value="${note.noteStatus}"></td>
					<td><input type="text" id="noteContent" name="noteContent"
						value="${note.noteContent}"></td>
					<td><c:out value="${note.createdAt}" /></td>
					<td><a href="delete?noteId=${note.noteId}"
						onclick="document.getElementById("deleteForm").submit()">delete</a></td>
					<td>
						<!-- <input type="button" name="updateButton" id="updateButton" value="update" 	formmethod="post" formaction="update"> -->
						<button type="submit" formmethod="post" formaction="update">update</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>



	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
		integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
		crossorigin="anonymous"></script>
</body>
<script type="text/javascript">
	function validation() 
	{
		let title = document.getElementById("noteTitle").value;
		let status = document.getElementById("noteStatus").value;
		let content = document.getElementById("noteContent").value;
		if ((title === '') || (status === '') || (content === '')) {
			document.getElementById("errMsg").innerHTML = 'All fields are mandatory.';
			return false;
		} else {
			document.getElementById("noteForm").submit();
		}
	}
	function update()
	{
		document.getElementById("deleteForm").submit();
	}
</script>
</html>