defmodule CaterpieWeb.QuizLiveTest do
  use CaterpieWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Caterpie.QMS

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp fixture(:quiz) do
    {:ok, quiz} = QMS.create_quiz(@create_attrs)
    quiz
  end

  defp create_quiz(_) do
    quiz = fixture(:quiz)
    %{quiz: quiz}
  end

  describe "Index" do
    setup [:create_quiz]

    test "lists all quizzes", %{conn: conn, quiz: quiz} do
      {:ok, _index_live, html} = live(conn, Routes.quiz_index_path(conn, :index))

      assert html =~ "Listing Quizzes"
      assert html =~ quiz.description
    end

    test "saves new quiz", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.quiz_index_path(conn, :index))

      assert index_live |> element("a", "New Quiz") |> render_click() =~
               "New Quiz"

      assert_patch(index_live, Routes.quiz_index_path(conn, :new))

      assert index_live
             |> form("#quiz-form", quiz: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#quiz-form", quiz: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.quiz_index_path(conn, :index))

      assert html =~ "Quiz created successfully"
      assert html =~ "some description"
    end

    test "updates quiz in listing", %{conn: conn, quiz: quiz} do
      {:ok, index_live, _html} = live(conn, Routes.quiz_index_path(conn, :index))

      assert index_live |> element("#quiz-#{quiz.id} a", "Edit") |> render_click() =~
               "Edit Quiz"

      assert_patch(index_live, Routes.quiz_index_path(conn, :edit, quiz))

      assert index_live
             |> form("#quiz-form", quiz: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#quiz-form", quiz: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.quiz_index_path(conn, :index))

      assert html =~ "Quiz updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes quiz in listing", %{conn: conn, quiz: quiz} do
      {:ok, index_live, _html} = live(conn, Routes.quiz_index_path(conn, :index))

      assert index_live |> element("#quiz-#{quiz.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#quiz-#{quiz.id}")
    end
  end

  describe "Show" do
    setup [:create_quiz]

    test "displays quiz", %{conn: conn, quiz: quiz} do
      {:ok, _show_live, html} = live(conn, Routes.quiz_show_path(conn, :show, quiz))

      assert html =~ "Show Quiz"
      assert html =~ quiz.description
    end

    test "updates quiz within modal", %{conn: conn, quiz: quiz} do
      {:ok, show_live, _html} = live(conn, Routes.quiz_show_path(conn, :show, quiz))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Quiz"

      assert_patch(show_live, Routes.quiz_show_path(conn, :edit, quiz))

      assert show_live
             |> form("#quiz-form", quiz: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#quiz-form", quiz: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.quiz_show_path(conn, :show, quiz))

      assert html =~ "Quiz updated successfully"
      assert html =~ "some updated description"
    end
  end
end
