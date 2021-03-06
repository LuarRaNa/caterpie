defmodule Caterpie.QMS do
  @moduledoc """
  The QMS context.
  """

  import Ecto.Query, warn: false
  alias Caterpie.Repo

  alias Caterpie.QMS.Quiz
  alias Caterpie.QMS.QuestionInfo
  alias Caterpie.QMS.Question
  alias Caterpie.QMS.Option
  alias Caterpie.Accounts.User

  @doc """
  Returns the list of quizzes.

  ## Examples

      iex> list_quizzes()
      [%Quiz{}, ...]

  """
  def list_quizzes(current_user = %User{}) do
    current_user
    |> Ecto.assoc(:quizzes)
    |> Repo.all()
  end

  @doc """
  Gets a single quiz.

  Raises `Ecto.NoResultsError` if the Quiz does not exist.

  ## Examples

      iex> get_quiz!(123)
      %Quiz{}

      iex> get_quiz!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quiz!(current_user = %User{}, id) do
    current_user
    |> Ecto.assoc(:quizzes)
    |> Repo.get!(id)
  end

  @doc """
  Creates a quiz.

  ## Examples

      iex> create_quiz(%{field: value})
      {:ok, %Quiz{}}

      iex> create_quiz(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quiz(current_user = %User{}, attrs \\ %{}) do
    current_user
    |> Ecto.build_assoc(:quizzes)
    |> Quiz.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quiz.

  ## Examples

      iex> update_quiz(quiz, %{field: new_value})
      {:ok, %Quiz{}}

      iex> update_quiz(quiz, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quiz(%Quiz{} = quiz, current_user = %User{}, attrs) do
    get_quiz!(current_user, quiz.id)
    |> IO.inspect()
    |> Quiz.changeset(attrs)
    |> IO.inspect()
    |> Repo.update()
  end

  @doc """
  Deletes a quiz.

  ## Examples

      iex> delete_quiz(quiz)
      {:ok, %Quiz{}}

      iex> delete_quiz(quiz)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quiz(%Quiz{} = quiz) do
    Repo.delete(quiz)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quiz changes.

  ## Examples

      iex> change_quiz(quiz)
      %Ecto.Changeset{data: %Quiz{}}

  """
  def change_quiz(%Quiz{} = quiz, attrs \\ %{}) do
    Quiz.changeset(quiz, attrs)
  end

  @doc """
  Returns the list of questions_info.

  ## Examples

      iex> list_questions_info()
      [%QuestionInfo{}, ...]

  """
  def list_questions_info(%Quiz{} = quiz) do
    quiz
    |> Ecto.assoc(:questions_info)
    |> Repo.all()
    |> Repo.preload(questions: from(q in Question, where: q.is_active == true))
  end

  @doc """
  Gets a single question_info.

  Raises `Ecto.NoResultsError` if the Question info does not exist.

  ## Examples

      iex> get_question_info!(123)
      %QuestionInfo{}

      iex> get_question_info!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question_info!(quiz = %Quiz{}, id) do
    quiz
    |> Ecto.assoc(:questions_info)
    |> Repo.get!(id)
    |> Repo.preload(questions: from(q in Question, where: q.is_active == true))
    |> Repo.preload(:options)
  end

  @doc """
  Creates a question_info.

  ## Examples

      iex> create_question_info(%{field: value})
      {:ok, %QuestionInfo{}}

      iex> create_question_info(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question_info(%Quiz{} = quiz, attrs \\ %{}) do
    quiz
    |> Ecto.build_assoc(:questions_info)
    |> QuestionInfo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question_info.

  ## Examples

      iex> update_question_info(question_info, %{field: new_value})
      {:ok, %QuestionInfo{}}

      iex> update_question_info(question_info, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question_info(%QuestionInfo{} = question_info, attrs) do
    update =
      update_in(attrs["questions"]["0"], fn map ->
        map
        |> Map.put("text", List.first(question_info.questions).text)
        |> Map.put("is_active", "false")
      end)

    update = put_in(update["questions"]["1"], %{"text" => attrs["questions"]["0"]["text"]})

    question_info
    |> QuestionInfo.changeset(update)
    |> Repo.update()
  end

  @doc """
  Deletes a question_info.

  ## Examples

      iex> delete_question_info(question_info)
      {:ok, %QuestionInfo{}}

      iex> delete_question_info(question_info)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question_info(%QuestionInfo{} = question_info) do
    Repo.delete(question_info)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question_info changes.

  ## Examples

      iex> change_question_info(question_info)
      %Ecto.Changeset{data: %QuestionInfo{}}

  """
  def change_question_info(%QuestionInfo{} = question_info, attrs \\ %{}) do
    question_info
    |> QuestionInfo.changeset(attrs)
  end

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  @doc """
  Returns the list of options.

  ## Examples

      iex> list_options()
      [%Option{}, ...]

  """
  def list_options do
    Repo.all(Option)
  end

  @doc """
  Gets a single option.

  Raises `Ecto.NoResultsError` if the Option does not exist.

  ## Examples

      iex> get_option!(123)
      %Option{}

      iex> get_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_option!(id), do: Repo.get!(Option, id)

  @doc """
  Creates a option.

  ## Examples

      iex> create_option(%{field: value})
      {:ok, %Option{}}

      iex> create_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_option(attrs \\ %{}) do
    %Option{}
    |> Option.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a option.

  ## Examples

      iex> update_option(option, %{field: new_value})
      {:ok, %Option{}}

      iex> update_option(option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_option(%Option{} = option, attrs) do
    option
    |> Option.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a option.

  ## Examples

      iex> delete_option(option)
      {:ok, %Option{}}

      iex> delete_option(option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_option(%Option{} = option) do
    Repo.delete(option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking option changes.

  ## Examples

      iex> change_option(option)
      %Ecto.Changeset{data: %Option{}}

  """
  def change_option(%Option{} = option, attrs \\ %{}) do
    Option.changeset(option, attrs)
  end
end
